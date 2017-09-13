# Scrivomatic: Scrivener & *Pandoc\{omatic\}*

## Introduction 

[Scrivener](http://literatureandlatte.com) is a program for all kinds of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and organise your text and reference materials without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Although Scrivener uses rich-text internally in the editor, it has very good integration with plain text [Markdown](https://en.wikipedia.org/wiki/Markdown) during compile. Extended markdown (MMD) for Scrivener output offers a number of advantages over rich-text: it creates more structured documents without lots of fussing in a Word processor or layout software. For example: 

* Binder headings are properly converted into semantic heading levels.
* Figures and figure captions get proper styling.
* Semantically styled block quotes, code blocks (with full syntax highlighting), and many inline styles.
* Mathematical equations are properly parsed to multipe output formats.
* You can generate multiple outputs (EPub,HTML,PDF,LaTeX,DOCX,ODT) from a single compile; and trigger other tools to automate many workflows.
* You can use a Microsoft Word/LibreOffice base file to provide customised styles for your documents without any fussing in a word processor afterwards.
* For academics, when you use [Pandoc (a markdown converter)](http://pandoc.org/index.html), you can *automagically generate a full [Bibliography](http://pandoc.org/MANUAL.html#citations)*. 
* For LaTeX users, there is a lot of flexibility using templates and meta-data.

This save you time, especially if you compile regularly during collaborative editing. So there are many benefits to compiling to markdown.  

Because of its great flexibility, Pandoc has many command line settings. We can simplify this hugely by using [Pandocomatic](https://heerdebeer.org/Software/markdown/pandocomatic/) or [Panzer](https://github.com/msprev/panzer), tools that manage Pandoc via the use of "templates". For each output format, the template specifies all the options, variables and metadata in a configuration file. These tools also allow you to run pre– and post–processors for more complex workflows (i.e. a post-processor could move a HTML file to a web server automatically). To use these templates in Scrivener, you specify its name in the front–matter, and all the settings are activated when Pandoc is run without any other fussing!

### TL;DR
1. Install Pandoc and Pandocomatic.
2. Configure one or more templates, you can base them on mine shared below.
3. In Scrivener, use a **front-matter** document containing meta-data at the top and compile to Multimarkdown.
4. Scrivener's compile automatically triggers scrivomatic/pandocomatic to automagically create the final output.

## Requirements 

Apart from **Scrivener**, you need to install **Pandoc** and **Pandocomatic**. This requires a minimal amount of typing into the macOS terminal. You can install Pandoc [manually](http://pandoc.org/installing.html), but it is generally better to use [Homebrew](https://brew.sh/) to install Pandoc, as it can keep everything up to date. So first,follow the [instructions to install Homebrew](https://brew.sh/), and then install pandoc through the `brew` command:

```bash
> brew install pandoc pandoc-citeproc pandoc-crossref
```

This will get you a working Pandoc. You should run the command `brew update` every so often to ensure these tools are *kept* up-to-date.

You use Ruby's `gem` command (built in to macOS) to install Pandocomatic (putting the binary in `/usr/local/bin`):

```bash
> sudo gem install paru pandocomatic -u /usr/local/bin
```

To keep both Pandoc and Pandocomatic *up-to-date*, you can run the update commands like so every week or so:

```bash
> brew update; sudo gem update
```


## Configuration 

The most important folder for this workflow is official pandoc DATA-DIR: `$HOME/.pandoc`. It is easiest to organise your templates, filters and other files there. It is a hidden folder by default, so you can use the terminal to manage it, or learn [how to unhide it first](https://www.google.com/search?q=unhide+folder+mac) if you will use Finder.

You can [explore my working .pandoc folder here](https://github.com/iandol/dotfiles/tree/master/pandoc). It is comprised of a series of subfolders organised into the files pandocomatic will use. You can also *install* my pandoc folder to your `$HOME/.pandoc` folder using the following terminal command:

```bash
svn export https://github.com/iandol/dotfiles/trunk/pandoc $HOME/.pandoc
```

You can look through a simplified [`pandocomatic.yaml` here](https://github.com/iandol/scrivomatic/blob/master/pandocomatic.yaml); this won't work without modification, but it does give you an idea of how this configuration file works. The `pandocomatic.yaml` file  resides in the pandoc DATA-DIR root.

Normally all the custom templates reside in `$HOME/.pandoc/templates`, filters in `$HOME/.pandoc/filters`, I prefer to symlink my Bibliography.bib into in `$HOME/.pandoc` and my CSL style files in `$HOME/.pandoc/csl`. 

### Tips for writing while in Scrivener 

With Scrivener 3's new styles system, there is a huge change to how you can write with markdown. You can use paragraph styles (like blockquote), and inline styles (like *emphasis* or superscript) as you would writing in rich text. During compile, you can add a prefix/suffix to create the required plain-text markdown. In Scrivener 2, you can still use formatting presets, but these will always be stripped out during the compile, so you need to write the markdown directly in the editor. I used to use formatting presets to visualise MD structure in Scrivener 2 (block quotes, code blocks, lists, tables, figure captions), and in Scrivener 3, I now use these both to *visualise* structure **and** to *generate* the Pandoc markup itself:  

![Figure 1 — The cursor shows **strong** and blockquote are both applied. Note whitespace is visualised and styles are used to give visual structure to the Scrivener writing environment. These will be transformed into the correct markdown on compile…](https://raw.githubusercontent.com/iandol/scrivomatic/Scrivener3/images/2.png)  

You can download my customised Scrivener 3 [scrivomatic compile preset here](https://raw.githubusercontent.com/iandol/scrivomatic/Scrivener3/Scrivomatic.scrformat). Install it and you can see how I convert my styles to markdown.  

**One setting is very useful in Scrivener**: Show invisible characters. This is because MD is sensitive to whitespace. You should aim to use whitespace consistently: For a new paragraph and between blocks of content I always use [space][space][return][return]. It is automatic for me and showing invisible characters makes potential formatting issues when compiling simple to fix.

**Use the Binder for all document structure**: try not to not use Headings within the text itself but form the document hierarchy in the Binder. Scrivener is great at compiling MD headings from the Binder structure.  

**Cross-referencing**: I use Scrivener links to cross-reference documents, and placeholder tags to cross-reference figures, equations and whatnot. But Pandoc does have a crossref filter and you could also use this.

## Compiling your Project: 

In Scrivener, first remove any Compile metadata specified in the user interface so it does not interfere with the Pandoc metadata. Then create a **front–matter** document with a metadata block right at the top like so. In this example, two templates are specified, and `pandocomatic` will run Pandoc twice to generate both a HTML & DOCX file from the same single Scrivener compile:

```yaml
---
title: "<$projecttitle>"
author:
  - John Doe
  - Joanna Doe
keywords: 
  - sample
  - pandoc
pandocomatic_:
  use-template:
    - paper-with-refs-html
    - paper-with-refs-docx
---

```

  This **front–matter** must be compiled **as–is** in the Scrivener compile settings (indentation in YAML must be **spaces** and not **tabs**). You compile your project to a Multimarkdown file, e.g. `mydoc.md`. Then you just run `pandocomatic mydoc.md` and it handles the Pandoc compile using the specified template (in this case both a HTML and a DOCX file are generated from the same Scrivener compile document). The Pandocomatic configuration file could look something like this for the DOCX template specified above; generating a bibliography using the APA style (with linked citations) and a table of contents amongst other things:

```yaml
  paper-with-refs-docx:
    pandoc:
      from: markdown
      to: docx
      standalone: true
      filter: pandoc-citeproc
      bibliography: core.bib
      citation-style: csl/apa.csl
      reference-docx: templates/custom.docx
      dpi: 300
      toc: true
    metadata: 
      notes-after-punctuation: false 
      link-citations: true
```


## Scrivomatic wrapper script 
I use a small tool, [`scrivomatic`](https://github.com/iandol/scrivomatic/raw/master/scrivomatic), which I run from Scrivener's processing panel and ensures the search path and environment are all correct for pandocomatic, panzer, LaTeX and Pandoc. You can also use pandocomatic directly.

Scrivomatic automatically adds the paths for `brew` and `MacTeX` installed tools, and if you've used [rbenv](https://github.com/rbenv/rbenv) or [conda](https://www.continuum.io/anaconda-overview) to install pandocomatic/panzer it adds these paths too. It can also create a log file of the conversion. Save [`scrivomatic`](https://github.com/iandol/scrivomatic/raw/master/scrivomatic), move it to a directory on your path, and make sure it can be executed like so:

```bash
mkdir -p $HOME/bin
mv $HOME/Downloads/scrivomatic $HOME/bin
chmod 755 $HOME/bin/scrivomatic
```

To run scrivomatic from Scrivener (with a `-v` verbose log placed in the compile directory):
    
![Figure 2 — Scrivener's processing panel in the compile preset.](https://raw.githubusercontent.com/iandol/scrivomatic/Scrivener3/images/processing.png)   

You can also run scrivomatic from the command line:

```
Usage: scrivomatic --input FILE [additional options]
    -i, --input FILE                 Input file?
    -o, --output [file]              Output file? Can be ignored for pandocomatic.
    -t, --to [format]                Pandoc Format? Can be ignored for pandocomatic.
    -c, --command [command]          Command to use? Default is pandocomatic
    -p, --path [dirpath]             Path to Search for Commands?
    -b, --build                      If LaTeX output, try to run latexmk
    -v, --[no-]verbose               Verbose output?
    -h, --help                       Prints this help!
```

And I include an [Alfred workflow](https://raw.githubusercontent.com/iandol/scrivomatic/Scrivener3/scrivomatic.alfredworkflow) so you can run scrivomatic directly from markdown files selected by Alfred:

![Figure 3 — Alfred Workflow.](https://raw.githubusercontent.com/iandol/scrivomatic/Scrivener3/images/3.png)


## Working with Bookends
[Bookends](http://www.sonnysoftware.com/) is an excellent reference manager for macOS which can be configured to output temporary citations for Scrivener in a format fully compatible with Pandoc. To set this up I'd first follow the nice tutorial here:

[BSAG » Bookends and Pandoc](https://www.rousette.org.uk/archives/bookends-and-pandoc/)

To export your references as a BIB file you can do tht manually from the Bookends GUI. However, I prefer to do this automatically every day or so using [this applescript](https://raw.githubusercontent.com/iandol/bookends-tools/master/source/toBibTeX.applescript), which you pass an output folder and comma-separated list of groups. This script can also be run directly from [Bookends Tools for Alfred](https://github.com/iandol/bookends-tools). I would recommend setting the option to save a JSON instead of BibTeX as Pandoc parses the JSON ~3X faster when processing documents, and with a big reference database that can save quite a lot of time.

