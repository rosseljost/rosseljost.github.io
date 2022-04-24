# rosseljost.github.io

My private webpage.

# Structure

- `/docs/`: This is the directory GitHub Pages uses to build the webpage.
    The Pandoc setup builds to this directory.
    The HTML files here are not manually created but it has to be committed to the repo.
- `/content/` contains the webpages sources files in Markdown format.
    These are first rendered using Jinja2 (still Markdown, but with the automatic content included; this is stored in a gitignore'd folder called `content-rendered`).
    The variables available to Jinja2 are a mix of user-defined values in the Pandoc YAML header and automatically gathered ones from the context of the Markdown file.
    The rendered files are then compiled using Pandoc into the `docs` folder.
- `/src/` contains the scripts that enable this behavior.
