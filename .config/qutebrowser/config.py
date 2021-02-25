# Autogenerated config.py
#
# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
#  import gruvbox
#  import adblock

## Block YouTube Advertisements
#  from qutebrowser.api import interceptor
#
#
#  def filter_yt(info: interceptor.request):
    #  url = info.request_url
    #  if (
            #  url.host() == "www.youtube.com"
            #  and url.path() == "/get_video_info"
            #  and "&adformat=" in url.query()
    #  ):
        #  info.block()
#
#
#  interceptor.register(filter_yt)


home = os.path.expanduser("~")


#  # gruvbox dark hard qutebrowser theme by Florian Bruhin <me@the-compiler.org>
#  #
#  # Originally based on:
#  #   base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
#  #   Base16 qutebrowser template by theova and Daniel Mulford
#  #   Gruvbox dark, hard scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)
#
#  bg0_hard = "#1d2021"
#  bg0_soft = '#32302f'
#  bg0_normal = '#282828'
#
#  bg0 = bg0_normal
#  bg1 = "#3c3836"
#  bg2 = "#504945"
#  bg3 = "#665c54"
#  bg4 = "#7c6f64"
#
#  fg0 = "#fbf1c7"
#  fg1 = "#ebdbb2"
#  fg2 = "#d5c4a1"
#  fg3 = "#bdae93"
#  fg4 = "#a89984"
#
#  bright_red = "#fb4934"
#  bright_green = "#b8bb26"
#  bright_yellow = "#fabd2f"
#  bright_blue = "#83a598"
#  bright_purple = "#d3869b"
#  bright_aqua = "#8ec07c"
#  bright_gray = "#928374"
#  bright_orange = "#fe8019"
#
#  dark_red = "#cc241d"
#  dark_green = "#98971a"
#  dark_yellow = "#d79921"
#  dark_blue = "#458588"
#  dark_purple = "#b16286"
#  dark_aqua = "#689d6a"
#  dark_gray = "#a89984"
#  dark_orange = "#d65d0e"
#
#  ### Completion
#
#  # Text color of the completion widget. May be a single color to use for
#  # all columns or a list of three colors, one for each column.
#  c.colors.completion.fg = [fg1, bright_aqua, bright_yellow]
#
#  # Background color of the completion widget for odd rows.
#  c.colors.completion.odd.bg = bg0
#
#  # Background color of the completion widget for even rows.
#  c.colors.completion.even.bg = c.colors.completion.odd.bg
#
#  # Foreground color of completion widget category headers.
#  c.colors.completion.category.fg = bright_blue
#
#  # Background color of the completion widget category headers.
#  c.colors.completion.category.bg = bg1
#
#  # Top border color of the completion widget category headers.
#  c.colors.completion.category.border.top = c.colors.completion.category.bg
#
#  # Bottom border color of the completion widget category headers.
#  c.colors.completion.category.border.bottom = c.colors.completion.category.bg
#
#  # Foreground color of the selected completion item.
#  c.colors.completion.item.selected.fg = fg0
#
#  # Background color of the selected completion item.
#  c.colors.completion.item.selected.bg = bg4
#
#  # Top border color of the selected completion item.
#  c.colors.completion.item.selected.border.top = bg2
#
#  # Bottom border color of the selected completion item.
#  c.colors.completion.item.selected.border.bottom = c.colors.completion.item.selected.border.top
#
#  # Foreground color of the matched text in the selected completion item.
#  c.colors.completion.item.selected.match.fg = bright_orange
#
#  # Foreground color of the matched text in the completion.
#  c.colors.completion.match.fg = c.colors.completion.item.selected.match.fg
#
#  # Color of the scrollbar handle in the completion view.
#  c.colors.completion.scrollbar.fg = c.colors.completion.item.selected.fg
#
#  # Color of the scrollbar in the completion view.
#  c.colors.completion.scrollbar.bg = c.colors.completion.category.bg
#
#  ### Context menu
#
#  # Background color of disabled items in the context menu.
#  c.colors.contextmenu.disabled.bg = bg3
#
#  # Foreground color of disabled items in the context menu.
#  c.colors.contextmenu.disabled.fg = fg3
#
#  # Background color of the context menu. If set to null, the Qt default is used.
#  c.colors.contextmenu.menu.bg = bg0
#
#  # Foreground color of the context menu. If set to null, the Qt default is used.
#  c.colors.contextmenu.menu.fg =  fg2
#
#  # Background color of the context menu’s selected item. If set to null, the Qt default is used.
#  c.colors.contextmenu.selected.bg = bg2
#
#  #Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
#  c.colors.contextmenu.selected.fg = c.colors.contextmenu.menu.fg
#
#  ### Downloads
#
#  # Background color for the download bar.
#  c.colors.downloads.bar.bg = bg0
#
#  # Color gradient start for download text.
#  c.colors.downloads.start.fg = bg0
#
#  # Color gradient start for download backgrounds.
#  c.colors.downloads.start.bg = bright_blue
#
#  # Color gradient end for download text.
#  c.colors.downloads.stop.fg = c.colors.downloads.start.fg
#
#  # Color gradient stop for download backgrounds.
#  c.colors.downloads.stop.bg = bright_aqua
#
#  # Foreground color for downloads with errors.
#  c.colors.downloads.error.fg = bright_red
#
#  ### Hints
#
#  # Font color for hints.
#  c.colors.hints.fg = bg0
#
#  # Background color for hints.
#  c.colors.hints.bg = 'rgba(250, 191, 47, 200)'  # bright_yellow
#
#  # Font color for the matched part of hints.
#  c.colors.hints.match.fg = bg4
#
#  ### Keyhint widget
#
#  # Text color for the keyhint widget.
#  c.colors.keyhint.fg = fg4
#
#  # Highlight color for keys to complete the current keychain.
#  c.colors.keyhint.suffix.fg = fg0
#
#  # Background color of the keyhint widget.
#  c.colors.keyhint.bg = bg0
#
#  ### Messages
#
#  # Foreground color of an error message.
#  c.colors.messages.error.fg = bg0
#
#  # Background color of an error message.
#  c.colors.messages.error.bg = bright_red
#
#  # Border color of an error message.
#  c.colors.messages.error.border = c.colors.messages.error.bg
#
#  # Foreground color of a warning message.
#  c.colors.messages.warning.fg = bg0
#
#  # Background color of a warning message.
#  c.colors.messages.warning.bg = bright_purple
#
#  # Border color of a warning message.
#  c.colors.messages.warning.border = c.colors.messages.warning.bg
#
#  # Foreground color of an info message.
#  c.colors.messages.info.fg = fg2
#
#  # Background color of an info message.
#  c.colors.messages.info.bg = bg0
#
#  # Border color of an info message.
#  c.colors.messages.info.border = c.colors.messages.info.bg
#
#  ### Prompts
#
#  # Foreground color for prompts.
#  c.colors.prompts.fg = fg2
#
#  # Border used around UI elements in prompts.
#  c.colors.prompts.border = f'1px solid {bg1}'
#
#  # Background color for prompts.
#  c.colors.prompts.bg = bg3
#
#  # Background color for the selected item in filename prompts.
#  c.colors.prompts.selected.bg = bg2
#
#  ### Statusbar
#
#  # Foreground color of the statusbar.
#  c.colors.statusbar.normal.fg = fg2
#
#  # Background color of the statusbar.
#  c.colors.statusbar.normal.bg = bg0
#
#  # Foreground color of the statusbar in insert mode.
#  c.colors.statusbar.insert.fg = bg0
#
#  # Background color of the statusbar in insert mode.
#  c.colors.statusbar.insert.bg = dark_aqua
#
#  # Foreground color of the statusbar in passthrough mode.
#  c.colors.statusbar.passthrough.fg = bg0
#
#  # Background color of the statusbar in passthrough mode.
#  c.colors.statusbar.passthrough.bg = dark_blue
#
#  # Foreground color of the statusbar in private browsing mode.
#  c.colors.statusbar.private.fg = bright_purple
#
#  # Background color of the statusbar in private browsing mode.
#  c.colors.statusbar.private.bg = bg0
#
#  # Foreground color of the statusbar in command mode.
#  c.colors.statusbar.command.fg = fg3
#
#  # Background color of the statusbar in command mode.
#  c.colors.statusbar.command.bg = bg1
#
#  # Foreground color of the statusbar in private browsing + command mode.
#  c.colors.statusbar.command.private.fg = c.colors.statusbar.private.fg
#
#  # Background color of the statusbar in private browsing + command mode.
#  c.colors.statusbar.command.private.bg = c.colors.statusbar.command.bg
#
#  # Foreground color of the statusbar in caret mode.
#  c.colors.statusbar.caret.fg = bg0
#
#  # Background color of the statusbar in caret mode.
#  c.colors.statusbar.caret.bg = dark_purple
#
#  # Foreground color of the statusbar in caret mode with a selection.
#  c.colors.statusbar.caret.selection.fg = c.colors.statusbar.caret.fg
#
#  # Background color of the statusbar in caret mode with a selection.
#  c.colors.statusbar.caret.selection.bg = bright_purple
#
#  # Background color of the progress bar.
#  c.colors.statusbar.progress.bg = bright_blue
#
#  # Default foreground color of the URL in the statusbar.
#  c.colors.statusbar.url.fg = fg4
#
#  # Foreground color of the URL in the statusbar on error.
#  c.colors.statusbar.url.error.fg = dark_red
#
#  # Foreground color of the URL in the statusbar for hovered links.
#  c.colors.statusbar.url.hover.fg = bright_orange
#
#  # Foreground color of the URL in the statusbar on successful load
#  # (http).
#  c.colors.statusbar.url.success.http.fg = bright_red
#
#  # Foreground color of the URL in the statusbar on successful load
#  # (https).
#  c.colors.statusbar.url.success.https.fg = fg0
#
#  # Foreground color of the URL in the statusbar when there's a warning.
#  c.colors.statusbar.url.warn.fg = bright_purple
#
#  ### tabs
#
#  # Background color of the tab bar.
#  c.colors.tabs.bar.bg = bg0
#
#  # Color gradient start for the tab indicator.
#  c.colors.tabs.indicator.start = bright_blue
#
#  # Color gradient end for the tab indicator.
#  c.colors.tabs.indicator.stop = bright_aqua
#
#  # Color for the tab indicator on errors.
#  c.colors.tabs.indicator.error = bright_red
#
#  # Foreground color of unselected odd tabs.
#  c.colors.tabs.odd.fg = fg2
#
#  # Background color of unselected odd tabs.
#  c.colors.tabs.odd.bg = bg2
#
#  # Foreground color of unselected even tabs.
#  c.colors.tabs.even.fg = c.colors.tabs.odd.fg
#
#  # Background color of unselected even tabs.
#  c.colors.tabs.even.bg = bg3
#
#  # Foreground color of selected odd tabs.
#  c.colors.tabs.selected.odd.fg = fg2
#
#  # Background color of selected odd tabs.
#  c.colors.tabs.selected.odd.bg = bg0
#
#  # Foreground color of selected even tabs.
#  c.colors.tabs.selected.even.fg = c.colors.tabs.selected.odd.fg
#
#  # Background color of selected even tabs.
#  c.colors.tabs.selected.even.bg = bg0
#
#  # Background color of pinned unselected even tabs.
#  c.colors.tabs.pinned.even.bg = bright_green
#
#  # Foreground color of pinned unselected even tabs.
#  c.colors.tabs.pinned.even.fg = bg2
#
#  # Background color of pinned unselected odd tabs.
#  c.colors.tabs.pinned.odd.bg = bright_green
#
#  # Foreground color of pinned unselected odd tabs.
#  c.colors.tabs.pinned.odd.fg = c.colors.tabs.pinned.even.fg
#
#  # Background color of pinned selected even tabs.
#  c.colors.tabs.pinned.selected.even.bg = bg0
#
#  # Foreground color of pinned selected even tabs.
#  c.colors.tabs.pinned.selected.even.fg = c.colors.tabs.selected.odd.fg
#
#  # Background color of pinned selected odd tabs.
#  c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.pinned.selected.even.bg
#
#  # Foreground color of pinned selected odd tabs.
#  c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.selected.odd.fg
#
#  # Background color for webpages if unset (or empty to use the theme's
#  # color).
#  c.colors.webpage.bg = bg4
#  ### End of gruvbox

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {"q": "quit", "w": "session-save", "wq": "quit --save"}

# Setting dark mode
# config.set("colors.webpage.darkmode.enabled", True)

# Adblock
#  print(str(config.configdir / 'config.py'))
c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
        "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext&_=223428",
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-social.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt"]

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "chrome-devtools://*")
#  config.set("content.cookies.accept", "no-unknown-3rdparty", "chrome-devtools://*")


# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "devtools://*")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}", "https://web.whatsapp.com/")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version} Edg/{upstream_browser_version}", "https://accounts.google.com/*")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set("content.headers.user_agent", "Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36", "https://*.slack.com/*")

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome://*/*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "qute://*/*")


# DT's settings

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.notifications", True, "https://www.reddit.com")

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.notifications", True, "https://www.youtube.com")

# Directory to save downloads to. If unset, a sensible OS-specific
# default is used.
# Type: Directory
c.downloads.location.directory = home + "/Downloads"

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = "always"

# Setting default page for when opening new tabs or new windows with
# commands like :open -t and :open -w .
c.url.default_page = "file:///{}/.surf/html/homepage.html".format(home)
#  c.url.default_page = "file:///home/dt/.surf/html/homepage.html"

# Search engines which can be used via the address bar.  Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` braces.  The following further
# placeholds are defined to configure how special characters in the
# search terms are replaced by safe characters (called 'quoting'):  *
# `{}` and `{semiquoted}` quote everything except slashes; this is the
# most   sensible choice for almost all search engines (for the search
# term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
# * `{quoted}` quotes all characters (for `slash/and&amp` this
# placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
# nothing (for `slash/and&amp` this placeholder   expands to
# `slash/and&amp`).  The search engine named `DEFAULT` is used when
# `url.auto_search` is turned on and something else than a URL was
# entered to be opened. Other search engines can be used by prepending
# the search engine name to the search term, e.g. `:open google
# qutebrowser`.
# Type: Dict
c.url.searchengines = {"DEFAULT": "https://duckduckgo.com/?q={}", "ddg": "https://duckduckgo.com/?q={}", "aw": "https://wiki.archlinux.org/?search={}", "goog": "https://www.google.com/search?q={}", "hoog": "https://hoogle.haskell.org/?hoogle={}", "re": "https://www.reddit.com/r/{}", "ub": "https://www.urbandictionary.com/define.php?term={}", "wiki": "https://en.wikipedia.org/wiki/{}", "yt": "https://www.youtube.com/results?search_query={}"}

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
# Type: List of QtColor, or QtColor
c.colors.completion.fg = ["#24d2af", "white", "white"]
#  c.colors.completion.fg = ["#9cc4ff", "white", "white"]

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = "#1c1f24"

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = "#232429"

# Foreground color of completion widget category headers.
# Type: QtColor
c.colors.completion.category.fg = "#f2b06a"
#  c.colors.completion.category.fg = "#e1acff"

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = "qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #000000, stop:1 #232429)"

# Top border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.top = "#3f4147"

# Bottom border color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.border.bottom = "#3f4147"

# Foreground color of the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.fg = "#282c34"

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = "#009185"
#  c.colors.completion.item.selected.bg = "#497950"
#  c.colors.completion.item.selected.bg = "#497990"

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = "#ffb62c"
#  c.colors.completion.item.selected.match.fg = "#c678dd"

# Foreground color of the matched text in the completion.
# Type: QtColor
c.colors.completion.match.fg = "#ffb62c"
#  c.colors.completion.match.fg = "#c678dd"

# Color of the scrollbar handle in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.fg = "white"

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = "#282c34"

# Background color for downloads with errors.
# Type: QtColor
c.colors.downloads.error.bg = "#ff6c6b"

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = "#282c34"

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = "#98be65"

# Background color of an info message.
# Type: QssColor
c.colors.messages.info.bg = "#282c34"

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = "#282c34"

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = "white"

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = "#497920"

# Background color of the statusbar in passthrough mode.
# Type: QssColor
c.colors.statusbar.passthrough.bg = "#34426f"

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = "#282c34"

# Foreground color of the URL in the statusbar when there's a warning.
# Type: QssColor
c.colors.statusbar.url.warn.fg = "yellow"

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = "#1c1f34"

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = "#282c34"

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = "#282c34"

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = "#282c34"

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = "#282c34"

# Background color of pinned unselected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.odd.bg = "seagreen"

# Background color of pinned unselected even tabs.
# Type: QtColor
c.colors.tabs.pinned.even.bg = "darkseagreen"

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = "#282c34"

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = "#282c34"

# Default font families to use. Whenever "default_family" is used in a
# font setting, it's replaced with the fonts listed here. If set to an
# empty value, a system-specific monospace default is used.
# Type: List of Font, or Font
c.fonts.default_family = "Ubuntu"
#  c.fonts.default_family = "UbuntuMono Nerd Font"
#  c.fonts.default_family = ""SauceCodePro Nerd Font""

# Default font size to use. Whenever "default_size" is used in a font
# setting, it's replaced with the size listed here. Valid values are
# either a float value with a "pt" suffix, or an integer value with a
# "px" suffix.
# Type: String
c.fonts.default_size = "12pt"

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = "12pt Ubuntu"
#  c.fonts.completion.entry = "11pt "SauceCodePro Nerd Font""

# Font used for the debugging console.
# Type: Font
c.fonts.debug_console = "12pt UbuntuMono Nerd Font"

# Font used for prompts.
# Type: Font
c.fonts.prompts = "default_size sans-serif"

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = "12pt Ubuntu"

# Font used for messages.
# Type: Font
c.fonts.messages.info = "12pt Ubuntu"
c.fonts.messages.warning = "12pt Ubuntu"
c.fonts.messages.error = "12pt Ubuntu"

# Bindings to use dmenu rather than qutebrowser's builtin search.
#config.bind("o", "spawn --userscript dmenu-open")
#config.bind("O", "spawn --userscript dmenu-open --tab")

# Bindings for normal mode
#  config.bind("M", "hint links spawn mpv {hint-url}")
config.bind("M", "hint links spawn --detach mpv --force-window yes {hint-url}")
config.bind("Z", "hint links spawn alacritty -e youtube-dl {hint-url}")
config.bind("t", "set-cmd-text -s :open -t")
config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")
config.bind("xx", "config-cycle statusbar.show always never;; config-cycle tabs.show always never")

config.bind("J", ":tab-prev")
config.bind("K", ":tab-next")
#  config.unbind("f")
#  config.bind(",f", ":hint")

config.bind("Sa", "bookmark-add")

# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(",ap", "config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice/apprentice-all-sites.css ''")
config.bind(",dr", "config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ''")
config.bind(",gr", "config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/gruvbox/gruvbox-all-sites.css ''")
config.bind(",sd", "config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ''")
config.bind(",sl", "config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ''")

