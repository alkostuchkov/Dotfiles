#!/usr/bin/env bash
#
# Script name: dmenu-search.sh
# Description: Search various search engines (inspired by surfraw).
# Dependencies: dmenu and a web browser
# GitLab: https://www.gitlab.com/dwt1/dmscripts
# License: https://www.gitlab.com/dwt1/dmscripts/LICENSE
# Contributors: Derek Taylor
#               Ali Furkan Yıldız

# Defining our web browser.
DMBROWSER="${BROWSER:-brave}"

# An array of search engines.  You can edit this list to add/remove
# search engines. The format must be: "engine_name - url".
# The url format must allow for the search keywords at the end of the url.
# For example: https://www.amazon.com/s?k=XXXX searches Amazon for 'XXXX'.
declare -a options=(
"amazon - https://www.amazon.com/s?k="
"archaur - https://aur.archlinux.org/packages/?O=0&K="
"archpkg - https://archlinux.org/packages/?sort=&q="
"archwiki - https://wiki.archlinux.org/index.php?search="
"arxiv - https://arxiv.org/search/?searchtype=all&source=header&query="
"bbcnews - https://www.bbc.co.uk/search?q="
"bing - https://www.bing.com/search?q="
"cliki - https://www.cliki.net/site/search?query="
"cnn - https://www.cnn.com/search?q="
"coinbase - https://www.coinbase.com/price?query="
"debianpkg - https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=names&keywords="
"discogs - https://www.discogs.com/search/?&type=all&q="
"duckduckgo - https://duckduckgo.com/?q="
"ebay - https://www.ebay.com/sch/i.html?&_nkw="
"github - https://github.com/search?q="
"gitlab - https://gitlab.com/search?search="
"google - https://www.google.com/search?q="
"googleimages - https://www.google.com/search?hl=en&tbm=isch&q="
"googlenews - https://news.google.com/search?q="
"imdb - https://www.imdb.com/find?q="
"lbry - https://lbry.tv/$/search?q="
"odysee - https://odysee.com/$/search?q="
"reddit - https://www.reddit.com/search/?q="
"slashdot - https://slashdot.org/index2.pl?fhfilter="
"socialblade - https://socialblade.com/youtube/user/"
"sourceforge - https://sourceforge.net/directory/?q="
"stack - https://stackoverflow.com/search?q="
"startpage - https://www.startpage.com/do/dsearch?query="
"stockquote - https://finance.yahoo.com/quote/"
"thesaurus - https://www.thesaurus.com/misspelling?term="
"translate - https://translate.google.com/?sl=auto&tl=en&text="
"urban - https://www.urbandictionary.com/define.php?term="
"wayback - https://web.archive.org/web/*/"
"webster - https://www.merriam-webster.com/dictionary/"
"wikipedia - https://en.wikipedia.org/wiki/"
"wiktionary - https://en.wiktionary.org/wiki/"
"wolfram - https://www.wolframalpha.com/input/?i="
"youtube - https://www.youtube.com/results?search_query="
"quit"
)

# Colors:
# Materia Manjaro
nf='#09dbc9'
nb='#222b2e'
sf='#dbdcd5'
sb='#009185'
fn='Ubuntu-16:normal'
# Gruvbox
# nf='#fea63c'
# nb='#282828'
# # sf='#dbdcd5'
# sb='#d79921'
# fn='Sarasa Mono SC Nerd-17:normal'

# Picking a search engine.
while [[ -z "$engine" ]]; do
    enginelist=$(printf '%s\n' "${options[@]}" | \
                 dmenu -i -l 20 -nf ${nf} -nb ${nb} \
                 -sf ${sf} -sb ${sb} \
                 -fn ${fn} -p 'Choose search engine:') || exit
    engineurl=$(echo "$enginelist" | awk '{print $NF}')
    engine=$(echo "$enginelist" | awk '{print $1}')
done

# Searching the chosen engine.
while [[ -z "$query" ]]; do
    query=$(echo "$engine" | \
            dmenu -i -l 1 -nf ${nf} -nb ${nb} \
            -sf ${sf} -sb ${sb} \
            -fn ${fn} -p 'Enter search query:') || exit
done

# Display search results in web browser
$DMBROWSER "$engineurl""$query"
