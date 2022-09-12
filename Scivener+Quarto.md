# Scrivener & Quarto Workflow

[Scrivener (macOS / Windows)](http://literatureandlatte.com) is a program for all types of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and manage text, ideas, figures and reference materials all in one place without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Though Scrivener uses rich text internally, it has excellent integration with plain text [markdown](https://en.wikipedia.org/wiki/Markdown), including Pandoc. Scrivener uses block and inline styles that can map to markdown; you write with editor styles but compile to markdown.

[Quarto (cross-platform)](https://quarto.org) is a scientific and technical writing system built on top of [Pandoc](https://pandoc.org). It enables one to use live code blocks, diagrams and very flexible layout to multiple output formats. It includes many useful extensions, and growing number of templates for academic journal submissions.

Please see this Scrivener forum post for more details: https://forum.literatureandlatte.com/t/scrivener-quarto-a-technical-academic-publishing-workflow/129769 for details.

**`DOWNLOADS:`**

-------

 **_A [full Scrivener project to use as a template](https://github.com/iandol/scrivomatic/blob/master/Quarto.scriv.zip)  for your own projects._**

**_The bundled Ruby code for the post-processing script [can be read here](https://github.com/iandol/scrivomatic/blob/master/quarto-run.rb)._**

**_An example [PDF compiled directly from Scrivener](https://github.com/iandol/scrivomatic/blob/master/sample-output/Quarto.pdf)._**

-------

The [sample workflow](https://github.com/iandol/scrivomatic/blob/master/Quarto.scriv.zip) uses Scrivener styles and Section Types and embeds a [custom post-processing script](https://github.com/iandol/scrivomatic/blob/master/quarto-run.rb). The major hurdle to combining Scrivener and Quarto concerns the placement of cross-referencing labels. The script moves these labels to the correct places. It also expands the path so Quarto can find LateX and other tools (Scrivener runs post-processing tools in a restricted path environment). The script will try to open any compilation log (see Scrivener post-processing pane parameters), and also open the final rendered document; so if you compile `Quarto.qmd` as PDF then it tries to open `Quarto.pdf` in your default PDF viewer.

## Requirements

1. Install Quarto (quarto bundles `pandoc` for you). Both [brew](https://brew.sh) and [scoop](https://scoop.sh) can install it for you.
2. You can use Quarto to install LaTeX: `quarto tools install tinytex`; *OR* you can use an existing TeX Live installation (I use BasicTeX). TinyTeX is small yet can auto-install required packages as needed…
3. For Mermaid / Graphviz install chromium if you don't have Chrome installed: `quarto tools install chromium`.
4. The script uses [Ruby](https://ruby-lang.org), which is already installed on macOS. You can use brew or scoop to install it otherwise.

## Tips

Quarto allows you to preview your compiled document. So after the first compilation from Scrivener you can point quarto to that `.qmd` file and it will continually render it in a browser for you each time you recompile: `quarto preview MyFile.qmd --to html`



