# Scrivomatic: Scrivener + *Pandoc*omatic (or Panzer) #

## Introduction ##

[Scrivener](http://literatureandlatte.com) is a program for all kinds of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and organise your text and reference materials without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Although Scrivener uses rich-text internally, it has very good integration with plain text [Markdown](https://en.wikipedia.org/wiki/Markdown). Markdown offers a number of advantages over rich-text in Scrivener: it creates more structured documents without lots of fussing in a Word processor or layout software. For example: figures with figure captions, block quotes, code blocks (with code highlighting) and more are all semantically styled, headings get proper outline levels by default, amongst other advantages. *And for academics, you can generate a full [Bibliography](http://pandoc.org/MANUAL.html#citations)* automatically. This save you time, especially if you compile regularly during collaborative editing.

The most powerful of all Markdown converters is [Pandoc](http://pandoc.org/index.html), which affords great flexibility in how markdown gets transformed to **many** output formats. You can use customised templates for Word, LibreOffice, HTML, LaTeX and many others. So, for example, you create a `custom.docx` where you specify your preferred styles/fonts/paragraph/page layouts in Word, and Pandoc uses this when generating your DOCX from Scrivener.  

The slight downside to Pandoc is a great many options that have to be specified on the command line. To handle this, tools like [Pandocomatic](https://heerdebeer.org/Software/markdown/pandocomatic/) and [Panzer](https://github.com/msprev/panzer), allow you to set up predefined "styles", where for each output format you can specify all pandoc options in a configuration file. These tools also allow you to run pre– and post–processors and filters for more advanced users. In Scrivener you simply specify the style you want for your document in the metadata, and all the settings are activated and Pandoc is run without any other fussing!  

## HOW-TO: ##

In Scrivener, first remove any Compile metadata specified in the user interface, then create a **front matter** document with a metadata block right at the top like so:

```yaml
---
title: "<$projecttitle>"
author:
  - John Doe
  - Joanna Doe
pandocomatic_:
  use-template:
    - paper-with-refs-html
    - paper-with-refs-docx
---

```

You compile your project to a Multimarkdown file, e.g. `mydoc.md`. Then you just run `pandocomatic mydoc.md` and it handles the Pandoc compile using the specified template (in this case both a HTML and a DOCX file are generated from the same Scrivener compile document). The Pandocomatic configuration file could look like this for the DOCX template specified above, generating a bibliography using the APA style amongst other things:

```yaml
  paper-with-refs-docx:
    preprocessors: []
    pandoc:
      from: markdown
      to: docx
      standalone: true
      filter: pandoc-citeproc
      bibliography: core.bib
      citation-style: apa.csl
      reference-docx: templates/custom.docx
      dpi: 300
      toc: false
      metadata: 
        - "notes-after-punctuation=false"  
        - "link-citations=true"
    postprocessors: []
```

## Requirements ##
Apart from **Scrivener**, you need to install **Pandoc** and either **Pandocomatic** or **Panzer**. This requires a minimal amount of typing into the terminal. I prefer Pandocomatic as it is a bit more flexible in terms of its output options, but Panzer is more 'elegant' in specifying the input options.   

For Pandoc on macOS you can [install manually](http://pandoc.org/installing.html), but it is generally better to use [Homebrew](https://brew.sh/) to install Pandoc as `brew` can keep everything up to date:

```shell
> brew install pandoc pandoc-citeproc pandoc-crossref
```

You use Ruby's `gem` command (built in to macOS) to install Pandocomatic (putting the binary in `/usr/local/bin`):

```shell
> sudo gem install pandocomatic -u /usr/local/bin
```

And Python's `pip` (also built in to macOS) if you want to use Panzer instead:

```shell
> pip install git+https://github.com/msprev/panzer
```

## Configuration ##
I've included a sample `pandocomatic.yaml` file above. You need to put this pandocomatic configuration file in the pandoc DATA-DIR, which is `$HOME/.pandoc` by default on macOS. If you want to use Panzer, it uses a file called `styles.yaml` placed in `$HOME/.panzer`.  

I place my custom templates in `$HOME/.pandoc/templates` and my bibliography and style files in `$HOME/.pandoc`

## scrivomatic wrapper script ##
I have also made a small tool, [`scrivomatic`](https://github.com/iandol/scrivomatic/raw/master/scrivomatic), which can be run from anywhere and ensures the search path and environment are correct for pandocomatic, panzer, LaTeX and Pandoc. Scrivomatic automatically adds the paths for `brew` and `MacTeX` tools, and if you've used [rbenv](https://github.com/rbenv/rbenv) or [anaconda](https://www.continuum.io/anaconda-overview) to install pandocomatic or panzer it adds these too. Save `scrivomatic`, then move it to a directory on your path. 

```shell
mkdir -p $HOME/bin
mv $HOME/Downloads/scrivomatic $HOME/bin
chmod 755 $HOME/bin/scrivomatic
```

To run scrivomatic from Scrivener (with a `-v` verbose log placed in the compile directory):

```
path: /Users/YOURUSERNAME/bin/scrivomatic
Arguments: -i "<$inputfile>" -o "<$outputname>.docx" -v >> scrivomatic.log 2>&1 
```

Then use your magic sauce to trigger this on a Scrivener compile automagically.  

