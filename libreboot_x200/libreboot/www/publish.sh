#!/usr/bin/env bash
#
# Copyright (C) 2017,2021 Leah Rowe <info@minifree.org>
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

[ "x${DEBUG+set}" = 'xset' ] && set -v
set -e

FILE=${1%.md}
TMPFILE=$(mktemp -t libreboot_www.XXXXXXXXXX)

cat "$1" > "$TMPFILE"

OPTS="-T Libreboot"

if [[ $FILE == "index" || $FILE == "./index" ]]; then
        TEMPLATE="template.homepage.html"
        OPTS="--css /headercenter.css"
else
        TEMPLATE="template.html"
        if [[ $FILE == *suppliers ]]
        then
            RETURN=""
        else
            if [[ $FILE == *index ]]
            then
                DEST="../"
            else
                DEST="./"
            fi

            RETURN=""
            OPTS="-T Libreboot"
        fi
fi

if [[ $FILE != "./docs/fdl-1.3" && $FILE != "docs/fdl-1.3" &&
      $FILE != "./conduct"      && $FILE != "conduct" ]]; then
    cat footer.md >> "$TMPFILE"
fi

# change out .md -> .html
sed -i -e 's/\.md\(#[a-zA-Z0-9_-]*\)\?\([])]*\)/.html\1\2/g' "$TMPFILE"

# work around issue #2872
TOC=$(grep -q "^x-toc-enable: true$" "$TMPFILE" && printf '%s\n' "--toc --toc-depth=2") || TOC=""

# work around heterogenous pandoc versions
SMART=$(pandoc -v | grep -q '2\.0' || printf '%s\n' "-f markdown+smart -t html") || SMART=""

# chuck through pandoc
#
# $OPTS must not be quoted, otherwise pandoc interprets '--css /headercenter.css'
# as one argument, when it is actually two.
pandoc $TOC $SMART "$TMPFILE" -s --css /global.css $OPTS \
        --template ${TEMPLATE} --metadata return="$RETURN" > "$FILE.html"

# generate section title anchors as [link]
sed -i -e 's_^<h\([123]\) id="\(.*\)">\(.*\)</h\1>_<div class="h"><h\1 id="\2">\3</h\1><a aria-hidden="true" href="#\2">[link]</a></div>_' "$FILE.html"

# clean up temporary file
rm -f "$TMPFILE"
