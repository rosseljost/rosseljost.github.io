#!/bin/bash

# Copyright (c) 2022 Jost Rossel

IN_DIR="$1"
OUT_DIR="$2"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$IN_DIR" || exit

shopt -s globstar
for file in **/*.md; do \
    out_filename="$OUT_DIR/${file%.*}.html"
    echo "Create $out_filename"
    mkdir -p "$(dirname "$out_filename")"
    pandoc \
        --katex \
        --section-divs \
        --filter "$HOME/.local/bin/pandoc-sidenote" \
        --from gfm+smart \
        --to html5 \
        --css "static/tufte.css" \
        --css "static/pandoc.css" \
        --css "static/tufte-extra.css" \
        --css "static/custom.css" \
        --toc \
        --standalone \
        --template="$SCRIPT_DIR/tufte.html5" \
        --output "$out_filename" \
        "$file"
        # --css pandoc-solarized.css \
done
