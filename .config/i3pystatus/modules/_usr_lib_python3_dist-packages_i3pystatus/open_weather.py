# -*- coding:utf-8 -*-

import time
import json
from urllib.parse import urlencode
from urllib.request import Request, urlopen

from i3pystatus import IntervalModule, Module
from i3pystatus.core.util import internet, require
from logging import (
    WARNING,
    Formatter,
    StreamHandler,
    captureWarnings,
    getLogger,
)
from logging.handlers import RotatingFileHandler

logger = getLogger(__package__)


try:
    import xmltodict

    def xmlparse(body):
        return xmltodict.parse(body)
except ImportError:
    # TODO: we could implement a similar parser by hand, but i'm lazy, so let's
    # punt for now
    def xmlparse(body):
        raise Exception("no xmltodict library")


# See documentation: https://openweathermap.org/current
QUERY_URL = 'http://api.openweathermap.org/data/2.5/weather?'
DEFAULT_APP_ID = '7834197c2338888258f8cb94ae14ef49'


class OpenWeatherResponseError(Exception):
    def __init__(self, resp_code, err_str=None):
        self.resp_code = resp_code
        self.err_str = err_str


def flatten_json(obj):
    out = {}

    def __inner(_json, name=''):
        if type(_json) is dict:
            for key, value in _json.items():
                __inner(value, name + key + '_')
        elif type(_json) is list:
            for i in range(len(_json)):
                __inner(_json[i], name + str(i) + '_')
        else:
            out[name[:-1]] = _json
    __inner(obj)
    return out


def degrees_to_direction(degrees):
    val = int(degrees / 22.5 + .5)
    arr = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE',
           'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW',
           'NNW']
    return arr[(val % 16)]


class _OpenWeatherResponseParser:
    def __init__(self, response, dateformat, timeformat):
        self.dateformat = dateformat
        self.timeformat = timeformat
        self._response = response
        self.data = self._parse(response)
        self._remap(self.data)
        if int(self.data['cod']) != 200:
            raise OpenWeatherResponseError(int(self.data['cod']))

    def _parse(self, response):
        return flatten_json(response)

    def _remap(self, data):
        data['location_lat'] = data.get('coord_lat', None)
        data['location_long'] = data.get('coord_lon', None)
        data['location_city'] = data.get('name', None)
        data['location_cityid'] = data.get('id', None)
        data['location_country'] = data.get('sys_country', None)
        data['sunrise'] = self._get_sunrise_time()
        data['sunset'] = self._get_sunset_time()
        data['isotime'] = self._get_dt()
        data['wind_direction'] = self._get_wind_direction()
        data['weather'] = data.get('weather_0_main', None)
        data['weather_details'] = data.get('weather_0_description', None)
        data['humidity'] = data.get('main_humidity', None)
        data['pressure'] = data.get('main_pressure', None)
        data['temp'] = round(data.get('main_temp', None))

    def _get_wind_direction(self):
        wd = self.data.get('wind_deg', None)
        if wd is None:
            return None
        return degrees_to_direction(wd)

    def _get_sunrise_time(self):
        dt = self.data.get('sys_sunrise', None)
        if dt is None:
            return None
        return time.strftime(self.timeformat, time.localtime(dt))

    def _get_sunset_time(self):
        dt = self.data.get('sys_sunset', None)
        if dt is None:
            return None
        return time.strftime(self.timeformat, time.localtime(dt))

    def _get_dt(self):
        dt = self.data.get('dt', None)
        if dt is None:
            return None
        return time.strftime(self.dateformat + self.timeformat, time.localtime(dt))


class GenPollUrl:
    """A generic text widget that polls an url and parses it using parse function"""

    url = None
    data = None
    parse = None
    json = True
    user_agent = 'Qtile'
    headers = {}
    xml = False

    settings = (
        ('url', 'Url'),
        ('data', 'Post Data'),
        ('parse', 'Parse Function'),
        ('json', 'Is Json?'),
        ('user_agent', 'Set the user agent'),
        ('headers', 'Extra Headers'),
        ('xml', 'Is XML?'),
    )

    def fetch(self, url, data=None, headers=None, is_json=True, is_xml=False):
        if headers is None:
            headers = {}
        req = Request(url, data, headers)
        res = urlopen(req)
        charset = res.headers.get_content_charset()

        body = res.read()
        if charset:
            body = body.decode(charset)

        if is_json:
            body = json.loads(body)

        if is_xml:
            body = xmlparse(body)
        return body

    def poll(self):
        if not self.parse or not self.url:
            return "Invalid config"

        data = self.data
        headers = {"User-agent": self.user_agent}
        if self.json:
            headers['Content-Type'] = 'application/json'

        if data and not isinstance(data, str):
            data = json.dumps(data).encode()

        headers.update(self.headers)
        body = self.fetch(self.url, data, headers, self.json, self.xml)

        try:
            text = self.parse(body)
        except Exception:
            logger.exception('got exception polling widget')
            text = "Can't parse"

        return text


class OpenWeather(GenPollUrl, IntervalModule):
    """ A weather widget, data provided by the OpenWeather API.

    Some format options:
        - location_city
        - location_cityid
        - location_country
        - location_lat
        - location_long

        - weather
        - weather_details
        - units_temperature
        - units_wind_speed
        - isotime
        - humidity
        - pressure
        - sunrise
        - sunset
        - temp
        - visibility
        - wind_speed
        - wind_deg
        - wind_direction

        - weather_0_icon  # See: https://openweathermap.org/weather-conditions; TODO: Use icons.
        - main_feels_like
        - main_temp_min
        - main_temp_max
        - clouds_all
    """
    color = "#ffffff"
    app_key = DEFAULT_APP_ID
    cityid = None
    location = None
    zip = None
    coordinates = None
    format = '{location_city}: {main_temp}°{units_temperature} {humidity}% {weather_details}'
    metric = True
    dateformat = '%Y-%m-%d '
    timeformat = '%H:%M'
    language = 'en'
    interval = 3600

    #  on_leftclick = OpenWeather.run()
    #  on_rightclick = "xdg-open {}".format(self.url)

    settings = (
        # One of (cityid, location, zip, coordinates) must be set.
        (
            'app_key',
            """Open Weather access key. A default is provided, but
            for prolonged use obtaining your own is suggested:
            https://home.openweathermap.org/users/sign_up"""
        ),
        (
            'cityid',
            """City ID. Can be looked up on e.g.:
            https://openweathermap.org/find
            Takes precedence over location and coordinates.
            Note that this is not equal to a WOEID."""
        ),
        (
            'location',
            """Name of the city. Country name can be appended
            like cambridge,NZ. Takes precedence over zip-code."""
        ),
        (
            'zip',
            """Zip code (USA) or "zip code,country code" for
            other countries. E.g. 12345,NZ. Takes precedence over
            coordinates."""
        ),
        (
            'coordinates',
            """Dictionary containing latitude and longitude
               Example: coordinates={"longitude": "77.22",
                                     "latitude": "28.67"}"""
        ),
        (
            'format',
            'Display format'
        ),
        ('metric', 'True to use metric/C, False to use imperial/F'),
        ('color', 'color'),
        (
            'dateformat',
            """Format for dates, defaults to ISO.
            For details see: https://docs.python.org/3/library/time.html#time.strftime"""
        ),
        (
            'timeformat',
            """Format for times, defaults to ISO.
            For details see: https://docs.python.org/3/library/time.html#time.strftime"""
        ),
        ('language',
         """Language of response. List of languages supported can
         be seen at: https://openweathermap.org/current under
         Multilingual support""")
    )

    @property
    def url(self):
        if not self.cityid and not self.location and not self.zip and not self.coordinates:
            return None

        params = {
            'appid': self.app_key or DEFAULT_APP_ID,
            'units': 'metric' if self.metric else 'imperial'
        }
        if self.cityid:
            params['id'] = self.cityid
        elif self.location:
            params['q'] = self.location
        elif self.zip:
            params['zip'] = self.zip
        elif self.coordinates:
            params['lat'] = self.coordinates['latitude']
            params['lon'] = self.coordinates['longitude']

        if self.language:
            params['lang'] = self.language

        return QUERY_URL + urlencode(params)

    def parse(self, response):
        try:
            rp = _OpenWeatherResponseParser(response, self.dateformat, self.timeformat)
        except OpenWeatherResponseError as e:
            return 'Error {}'.format(e.resp_code)

        data = rp.data
        data['units_temperature'] = 'C' if self.metric else 'F'
        data['units_wind_speed'] = 'Km/h' if self.metric else 'm/h'

        #  return self.format.format(**data)
        return data  # data is a dict

    @require(internet)
    def run(self):
        #  response = self.poll()
        #  self.data = self.parse(response)
        self.data = self.poll()
        self.output = {
            "full_text": self.format.format(**self.data),
            "color": self.color
        }


if __name__ == "__main__":
    ow = OpenWeather(coordinates={"longitude": "30.9754", "latitude": "52.4345"})
    ow.run()
    print(ow.output)

