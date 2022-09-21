# Scrivener + Quarto Template

See the [Scrivener forum post for the latest details…](https://forum.literatureandlatte.com/t/scrivener-quarto-a-technical-academic-publishing-workflow/129769)

[Scrivener (macOS / Windows)](http://literatureandlatte.com) is a program for all types of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and manage text, ideas, figures and reference materials all in one place without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Though Scrivener uses rich text internally, it has excellent integration with plain text [markdown](https://en.wikipedia.org/wiki/Markdown), including Pandoc. Scrivener uses block and inline styles that can map to markdown; you write with editor styles but compile to markdown.

[Quarto (cross-platform)](https://quarto.org) is a scientific and technical writing system built on top of [Pandoc](https://pandoc.org). It enables one to use live code blocks, diagrams and very flexible layout to multiple output formats. It includes many useful extensions, and growing number of templates for academic journal submissions.

-------

**`DOWNLOADS:`**

**_[Scrivener + Quarto Project Template](https://github.com/iandol/scrivomatic/raw/master/Scrivener%20%2B%20Quarto.scrivtemplate): save this file removing any `.txt` suffix if added by your browser; import the `Scrivener + Quarto.scrivtemplate` file using `File → New Project…` dialog, and then select the `Non-Fiction → Scrivener + Quarto` template to create your new project!_**

 **_[Alternative: project as a regular ZIP file](https://github.com/iandol/scrivomatic/raw/master/Quarto.scriv.zip)._**

**_[Example PDF compiled directly from the above Scrivener project](https://github.com/iandol/scrivomatic/raw/master/sample-output/Quarto.pdf)._**

**_The bundled [post-processing script can be checked here](https://github.com/iandol/scrivomatic/blob/master/quarto-run.rb)._**

**_Quarto supports many journal templates and extensions which can be downloaded and installed. [See this awesome list for a curated list](https://github.com/mcanouil/awesome-quarto#awesome-quarto-)._**

-------

Most Quarto features can be used via three routes, and the Scrivener + Quarto template demonstrates all three:

1. Using **Scrivener Styles** — examples: [Callouts](https://quarto.org/docs/authoring/callouts.html), [Live Code](https://quarto.org/docs/computations/r.html). The main caveat with Styles is Scrivener doesn't allow paragraph [block] styles to be nested.
2. Using **Scrivener Section Layouts** — example: [multi-item images / tables](https://quarto.org/docs/authoring/figures.html#subfigures) using cross-referencing attributes. This method allows nested blocks. Scrivener document templates are provided.
3. You can always write *plain markdown* in the editor if you prefer…

Quarto's [documentation is excellent](https://quarto.org/docs/guide/). Some of the cool features that Quarto includes and work well with Scrivener:

1. Panels with sub-figures and sub-tables. 
1. Based on Tufte, you can use margins for notes, figures, equations etc. Layout can be modified to [span the page in many ways](https://quarto.org/docs/authoring/article-layout.html). You can rewrite layouts using Pandoc's templating language.
1. Comprehensive cross-referencing, using Pandoc's @citation markup (based on [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref)). For sub-figures / tables, you can add labels, like Figure 3(c) and these can be customised.
1. Academic author + affiliation metadata «similar to [scrivomatic](https://github.com/iandol/scrivomatic) and [pandoc scholar](https://github.com/pandoc-scholar/pandoc-scholar)».
1. Run Python, R, Julia code "live" to plot figures on each compile.
1. Use graphing engines like [Mermaid](https://mermaid-js.github.io/) and [Graphviz](https://graphviz.org).
1. HTML output has *lots* of cool tweaks, see <https://quarto-dev.github.io/quarto-gallery/page-layout/tufte.html> for example.
1. Quarto allows [installable extensions](https://quarto.org/docs/extensions/), so you can plug in new layout templates and code to extend its powers!
1. As it is Pandoc-based, there are many formats supported and Pandoc's custom filters customise many aspects of the final document.

Quarto installs [almost] everything required (you can use it to manage Pandoc, LaTeX, Graphviz, Mermaid and other tools *all-in-one*). For LaTeX it can install and update [TinyTeX](https://yihui.org/tinytex/), which enables a small install footprint and automated addition of packages from CTAN as required (no fussing with `tlmgr`)…

-----------

## Requirements

1. Install Quarto (quarto bundles `pandoc` for you). Both [`brew` «macOS/Linux»](https://brew.sh) and [`scoop` «Windows»](https://scoop.sh) can install quarto for you.
2. You can then use Quarto to install LaTeX: `quarto tools install tinytex` — TinyTeX is small yet can auto-install required packages if they are missing as needed; *OR* you can use an existing TeX Live installation (I use [BasicTeX](https://tug.org/mactex/morepackages.html) on macOS).
3. For Mermaid & Graphviz, Quarto can install a Chromium runtime if you don't have Chrome installed: `quarto tools install chromium`. 
4. The script requires [Ruby](https://ruby-lang.org), which is already installed on macOS. You can use `brew` or `scoop` to install/update it otherwise.

## Tips

Quarto allows you to preview your compiled document. So after the first compilation from Scrivener you can point `quarto` to that `.qmd` file and it will continually render it in a browser for you each time you recompile: `quarto preview MyFile.qmd --to html`



