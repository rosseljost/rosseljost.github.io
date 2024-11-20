#!/bin/bash

# Copyright (c) 2022 Jost Rossel

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SRC_DIR="$1"
TMP_DIR="$2"
DST_DIR="$3"
META_DIR="$4"

# clean output directories
cd "$TMP_DIR" && rm -r -- **/*.md *.md
cd "$DST_DIR" && rm -r -- **/*.html *.html

cd "$SCRIPT_DIR" || exit

. /venv/bin/activate && python3 jinja.py "$SRC_DIR" "$TMP_DIR" "$DST_DIR" "$META_DIR"

bash pandoc.sh "$TMP_DIR" "$DST_DIR" "$META_DIR"

# own all files to standard user (docker might own folders created from the script)
chown -R 1000:1000 "$SRC_DIR"
chown -R 1000:1000 "$TMP_DIR"
chown -R 1000:1000 "$DST_DIR"
