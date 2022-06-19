# Copyright (c) 2022 Jost Rossel

from glob import glob
from pathlib import Path
from os.path import join
from os import chdir
import frontmatter
from staticjinja import Site
import sys

def get_contexts(md_dir: str):
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

    filenames = glob(join("**", "*.md"), recursive=True, )
    for filename in filenames:
        path = Path(filename)
        with open(path, "r", encoding="utf-8") as file:
            metadata, _ = frontmatter.parse(file.read())
        _deep_set_dict(path, metadata)
        file_contexts.append((filename, {"local": metadata}))

    return {"global": global_context}, file_contexts


if __name__ == "__main__":
    in_dir = Path(sys.argv[1])
    out_dir = Path(sys.argv[2])

    global_context, file_contexts = get_contexts(in_dir)

    site = Site.make_site(
        env_globals=global_context,
        contexts=file_contexts,
        searchpath=in_dir,
        outpath=out_dir,
        extensions=['jinja2.ext.do'],
    )
    site.render()
