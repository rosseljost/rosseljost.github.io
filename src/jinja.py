# Copyright (c) 2022 Jost Rossel

from glob import glob
from os.path import join
from os import chdir

import frontmatter
import json
from pathlib import Path
import sys

from staticjinja import Site


def get_contexts_old(md_dir: str):
    """
    Returns a dict representing the .md files in the given directory
    and the contexts defined in the YAML of each document.
    """
    chdir(md_dir)
    global_context = {}
    file_contexts = []

    def _deep_set_dict(key: Path, val):
        _context = global_context
        for folder in key.parts[:-1]:
            if folder not in _context:
                global_context[folder] = {}
            _context = global_context[folder]
        _context[key.parts[-1].replace(".md", "")] = val

    filenames = glob(
        join("**", "*.md"),
        recursive=True,
    )
    for filename in filenames:
        path = Path(filename)
        with open(path, "r", encoding="utf-8") as file:
            metadata, _ = frontmatter.parse(file.read())
        _deep_set_dict(path, metadata)
        file_contexts.append((filename, {"local": metadata}))

    return {"global": global_context}, file_contexts


def get_contexts(content_dir: str, dst_dir: str) -> tuple[dict]:
    """
    Returns a dict representing the .md files in the given directory
    and the contexts defined in the YAML of each document.
    """
    static_context = {}  # all JSON files in /static
    global_context = {}  # contains the frontmatter of all .md files in /content
    file_contexts = []  # contains the frontmatter of each .md file in /content

    def _deep_set_dict(base_context: dict, key: Path, val):
        """Sets a value in a nested dictionary; each part of the path is a key
        (including the filename without extension)."""
        _context = base_context
        for folder in key.parts[:-1]:
            if folder not in _context:
                _context[folder] = {}
            _context = _context[folder]
        _context[Path(key.parts[-1]).stem] = val

    for path in Path(content_dir).glob("**/*.md"):
        filename = str(path)
        with path.open("r", encoding="utf-8") as file:
            metadata, _ = frontmatter.parse(file.read())
        _deep_set_dict(global_context, path.relative_to(content_dir), metadata)
        file_contexts.append((filename, {"local": metadata}))

    static_dir = Path(dst_dir, "static")
    for path in static_dir.glob("**/*.json"):
        with path.open("r", encoding="utf-8") as file:
            content = json.load(file)
        _deep_set_dict(static_context, path.relative_to(static_dir), content)

    return {"global": global_context, "static": static_context}, file_contexts


def main():
    src_dir = Path(sys.argv[1]).absolute()
    tmp_dir = Path(sys.argv[2]).absolute()
    dst_dir = Path(sys.argv[3]).absolute()

    global_context, file_contexts = get_contexts(src_dir, dst_dir)

    site = Site.make_site(
        env_globals=global_context,
        contexts=file_contexts,
        searchpath=src_dir,
        outpath=tmp_dir,
        extensions=["jinja2.ext.do"],
    )
    site.render()


if __name__ == "__main__":
    main()
