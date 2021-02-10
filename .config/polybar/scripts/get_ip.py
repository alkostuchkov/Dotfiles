#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import requests

try:
    r = requests.get("https://ipinfo.io/ip")
    print(r.text, end="")
except:
    print("No Connection", end="")

#  print(r.status_code)
#  print(r.json)

