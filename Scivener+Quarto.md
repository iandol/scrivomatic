# Scrivener & Quarto Workflow

[Scrivener (macOS / Windows)](http://literatureandlatte.com) is a program for all types of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and manage text, ideas, figures and reference materials all in one place without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Though Scrivener uses rich text internally, it has excellent integration with plain text [markdown](https://en.wikipedia.org/wiki/Markdown). 

[Quarto (cross-platform)](https://quarto.org) is a scientific and technical writing system built on top of [Pandoc](https://pandoc.org). It enables one to use live code blocks and diagrams and very flexible layout to multiple output formats. 

This workflow uses Scrivener styles and a [custom processing script](https://github.com/iandol/scrivomatic/blob/master/quarto-run.rb) to enable Scrivener to drive Quarto's rendering automatically. The major hurdle to combining Scrivener and Quarto concerns the placement of cross-referencing labels. The script moves these labels to the correct places. It also expands the path so Quarto can find LateX and other tools. The script will try to open the compilation log (see Scrivener post-processing pane parameters), and open the final rendered document, so if you compile `Quarto.qmd` to PDF then it tries to open `Quarto.pdf`.

You can download a [sample Scrivener project here](https://github.com/iandol/scrivomatic/blob/master/Quarto.scriv.zip).

## Requirements

1. Install Quarto (quarto bundles `pandoc` so no need to install that).
2. You can use Quarto to install LaTeX: `quarto tools install tinytex`; *OR* you can use an existing TeX Live installation (I use BasicTeX). TinyTeX is small yet can auto-install required packages as needed…
3. For Mermaid / Graphviz install chromium if you don't have Chrome installed: `quarto tools install chromium`.
4. The script uses ruby, which is already installed on macOS.

## Tips

Quarto allows you to preview your compiled document. So after the first compilation you can point quarto to that `.qmd` file and it will continually render it in a browser for you each tome you recompile: `quarto preview MyFile.qmd --to html`



