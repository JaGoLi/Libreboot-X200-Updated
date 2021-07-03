#!/usr/bin/env bash
#
# Copyright (C) 2017 Alyssa Rosenzweig <alyssa@rosenzweig.io>
# Copyright (C) 2017 Michael Reed <michael@michaelreed.io>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

BLOGTITLE="Libreboot News"
BLOGBASE="https://libreboot.org/"
BLOGDESCRIPTION="News on Libreboot development"

# MANIFEST determines the order of news articles in news/index.md
FILES=$(< news/MANIFEST)


# usage: title file
title() {
    sed -n 1p "$1" | sed -e s-^..--
}

# usage: meta file
meta() {
    file=$1
    URL=$(printf '%s\n' "${file%.md}.html" | sed -e s-news/--)

    printf '%s\n' "[$(title "$file")]($URL){.title}"
    printf '%s\n' "[$(sed -n 3p "$file" | sed -e s-^..--)]{.date}"

    printf '\n'
    printf '\n'
}

# usage: rss_header
rss_header() {
    printf '%s\n' '<rss version="2.0">'
    printf '%s\n' '<channel>'

    printf '%s\n' "<title>$BLOGTITLE</title>"
    printf '%s\n' "<link>${BLOGBASE}news/</link>"
    printf '%s\n' "<description>$BLOGDESCRIPTION</description>"
}

# usage: rss_main file
rss_main() {
    file=$1

    # render content and escape
    desc=$(sed -e 's/</\&lt;/g' "${file%.md}.bare.html" | sed -e 's/>/\&gt;/g')
    url="${file%.md}.html"

    printf '%s\n' '<item>'
    printf '%s\n' "<title>$(title "$file")</title>"
    printf '%s\n' "<link>$BLOGBASE$url</link>"
    printf '%s\n' "<description>$desc</description>"
    printf '%s\n' '</item>'
}

# usage: rss_footer
rss_footer() {
    printf '%s\n' '</channel>'
    printf '%s\n' '</rss>'
}


# generate the index file
cat news-list.md > news/index.md
for f in $FILES
do
    meta "$f" >> news/index.md
done

# generate the RSS index
rss_header > news/feed.xml
for f in $FILES
do
    rss_main "$f" >> news/feed.xml
done
rss_footer >> news/feed.xml

cp news/feed.xml feed.xml
