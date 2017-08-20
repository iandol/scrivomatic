# Scrivomatic: Scrivener & *Pandoc*[omatic] 

## Introduction 

[Scrivener](http://literatureandlatte.com) is a program for all kinds of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and organise your text and reference materials without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Although Scrivener uses rich-text internally, it has very good integration with plain text [Markdown](https://en.wikipedia.org/wiki/Markdown). Markdown (MD) offers a number of advantages over rich-text in Scrivener: it creates more structured documents without lots of fussing in a Word processor or layout software. For example: figures with figure captions, block quotes, code blocks (with code highlighting) and more are all semantically styled, headings get proper outline levels by default, amongst other advantages. *And for academics, if you use Pandoc you can generate a full [Bibliography](http://pandoc.org/MANUAL.html#citations)* automatically. This save you time, especially if you compile regularly during collaborative editing. So there are many benefits to compiling to markdown.

[Pandoc](http://pandoc.org/index.html) can then read your compiled document and convert it to **many** output formats. You can use customised templates for Word, LibreOffice, HTML, PDF, slideshows and many others. So, for example, you create a `custom.docx` where you specify your preferred styles/fonts/paragraph/page layouts in Word, and Pandoc can use this when building the DOCX from your Scrivener compile.  

Because of its great power, Pandoc has many command line settings. We can simplify by using [Pandocomatic (automatic Pandoc 🤓)](https://heerdebeer.org/Software/markdown/pandocomatic/) or [Panzer](https://github.com/msprev/panzer), tools that configure Pandoc via "templates". For each output format, the template specifies all the options, variables and metadata in a configuration file. These tools also allow you to run pre– and post–processors for more complex workflows (i.e. a post-processor could move a HTML file to a web server automatically). To use these templates in Scrivener, you specify its name in the front–matter, and all the settings are activated when Pandoc is run without any other fussing!

## Requirements 

Apart from **Scrivener**, you need to install **Pandoc** and either **Pandocomatic** or **Panzer**. This requires a minimal amount of typing into the macOS terminal. I prefer Pandocomatic as it is a more flexible in terms of its [multi]output options.

For Pandoc on macOS you can [install manually](http://pandoc.org/installing.html), but it is generally better to use [Homebrew](https://brew.sh/) to install Pandoc as `brew` can keep everything up to date. So follow the [instructions to install Homebrew](https://brew.sh/) first, then:

```bash
> brew install pandoc pandoc-citeproc pandoc-crossref
```

This should get you a working Pandoc. You should run the command `brew update` every so often to ensure these tools are *kept* up-to-date.

You use Ruby's `gem` command (built in to macOS) to install Pandocomatic (putting the binary in `/usr/local/bin`):

```bash
> sudo gem install pandocomatic -u /usr/local/bin
```

You run `sudo gem update` every so often to keep pandocomatic up-to-date. If you prefer to use Panzer, Python's `pip` (also built in to macOS) will install it for you like so:

```bash
> pip install git+https://github.com/msprev/panzer
```

## Configuration 

The most important folder for this workflow is `$HOME/.pandoc` — this is the official pandoc DATA-DIR, and you should organise your templates, filters and other files there. It is hidden by default, so you need to know [how to unhide it first](https://www.google.com/search?q=unhide+folder+mac). You can [explore my working .pandoc folder here](https://github.com/iandol/dotfiles/tree/master/pandoc). I've included a more simple sample `pandocomatic.yaml` file above. This won't work without some modification but it does give you an idea of how this configuration works. You need to put the pandocomatic configuration file in the pandoc DATA-DIR. If you want to use Panzer, it uses a file called `styles.yaml` placed in `$HOME/.panzer`.  

I place all custom templates in `$HOME/.pandoc/templates`, my filters in `$HOME/.pandoc/filters` my bibliography BIB file in `$HOME/.pandoc` and my CSL style files in `$HOME/.pandoc/csl`. 

### Tips for writing while in Scrivener 

You can use formatting presets or styles however you want in Scrivener, but remember these will all be stripped out during the compile. I use formatting presets to visualise MD structure in Scrivener (block quotes, code blocks, lists, tables, figure captions):  

![Figure 1 — Note whitespace is visualised and formatting presets are used to give visual structure to the Scrivener environment.](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/1.png)  

**One setting is very useful in Scrivener**: Show invisible characters. This is because MD is sensitive to whitespace. You should aim to use whitespace consistently: For a new paragraph and between blocks of content I always use [space][space][return][return]. It is automatic for me and showing invisible characters makes potential formatting issues when compiling simple to fix.

**Use the Binder for all document structure**. Try not to not use Headings within the text itself but form the document hierarchy in the Binder. Scrivener is great at compiling MD headings from the Binder structure.

## Compiling your Project: 

In Scrivener, first remove any Compile metadata specified in the user interface so it does not interfere with the Pandoc metadata. Then create a **front–matter** document with a metadata block right at the top like so. Note two templates are specified, and `pandocomatic` will run Pandoc twice in this case to generate a HTML & DOCX file:

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
...

```

This **front–matter** must be compiled **as–is** in the Scrivener compile settings. You compile your project to a Multimarkdown file, e.g. `mydoc.md`. Then you just run `pandocomatic mydoc.md` and it handles the Pandoc compile using the specified template (in this case both a HTML and a DOCX file are generated from the same Scrivener compile document). The Pandocomatic configuration file could look something like this for the DOCX template specified above, generating a bibliography using the APA style amongst other things:

```yaml
  paper-with-refs-docx:
    preprocessors: []
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
    postprocessors: []
```


## Scrivomatic wrapper script 
I have made a small tool, [`scrivomatic`](https://github.com/iandol/scrivomatic/raw/master/scrivomatic), which can be run from anywhere and ensures the search path and environment are correct for pandocomatic, panzer, LaTeX and Pandoc. Scrivomatic automatically adds the paths for `brew` and `MacTeX` installed tools, and if you've used [rbenv](https://github.com/rbenv/rbenv) or [anaconda](https://www.continuum.io/anaconda-overview) to install pandocomatic or panzer it adds these too. Save `scrivomatic`, then move it to a directory on your path. 

```bash
mkdir -p $HOME/bin
mv $HOME/Downloads/scrivomatic $HOME/bin
chmod 755 $HOME/bin/scrivomatic
```

To run scrivomatic from the command line:

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

To run scrivomatic from Scrivener (with a `-v` verbose log placed in the compile directory):

```bash
path: /Users/YOURUSERNAME/bin/scrivomatic
Arguments: --input "<$inputfile>" -v >> scrivomatic.log 2>&1
```

Then use your magic sauce to trigger this on a Scrivener compile automagically.  

