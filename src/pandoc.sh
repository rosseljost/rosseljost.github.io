#!/bin/bash

# Copyright (c) 2022 Jost Rossel

IN_DIR="$1"
OUT_DIR="$2"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$IN_DIR" || exit

shopt -s globstar
for file in **/*.md; do \
    prefix=$(python3 -c "n=len([x for x in '$file'.split('/') if len(x)>0])-1; print('../' * n)")
    out_filename="$OUT_DIR/${file%.*}.html"
    echo "Create $out_filename"
    mkdir -p "$(dirname "$out_filename")"
    pandoc \
        --katex \
        --section-divs \
        --filter "$HOME/.local/bin/pandoc-sidenote" \
        --from markdown+raw_html+smart \
        --to html5 \
        --css "${prefix}static/tufte.css" \
        --css "${prefix}static/pandoc.css" \
        --css "${prefix}static/tufte-extra.css" \
        --css "${prefix}static/custom.css" \
        --toc \
        --standalone \
        --template="$SCRIPT_DIR/tufte.html5" \
        --output "$out_filename" \
        "$file"
        # --css pandoc-solarized.css \
done
