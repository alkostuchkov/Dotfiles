#!/usr/bin/env python3

import urllib.request


def check_connection():
    try:
        urllib.request.urlopen("https://www.google.com")
        return "🟢"
        # return "🟩 🟢 ✅ 👍"
    except:
        try:  # if www.google.com is not available try www.yandex.ru
            urllib.request.urlopen("https://www.yandex.ru")
            return "🟢"
        except:
            return "🔴"
            # return "🟥 🔴 ⛔ 🚫 "
    finally:
        pass


if __name__ == "__main__":
    print(check_connection())
