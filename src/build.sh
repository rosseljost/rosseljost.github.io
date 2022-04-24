#!/bin/bash

# Copyright (c) 2022 Jost Rossel

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SRC_DIR="$1"
TMP_DIR="$2"
DST_DIR="$3"

# mkdir -p "$SRC_DIR"
# mkdir -p "$TMP_DIR"
# mkdir -p "$DST_DIR"

cd "$SCRIPT_DIR" || exit

python3 jinja.py "$SRC_DIR" "$TMP_DIR"

bash pandoc.sh "$TMP_DIR" "$DST_DIR"
