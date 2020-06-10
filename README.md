# Scrivomatic: Scrivener & *Pandoc\{omatic\}* #

### Table of Contents ###
* [General Introduction](#introduction)
    - [Simple Summary](#tldr-simple-summary)
    - [Installing the required tools…](#requirements)
    - [Configuring the workflow](#configuration)
* [The Writing Workflow in Scrivener](#writing-in-scrivener)
    - [Use the Binder for all document structure](#use-the-binder-for-all-document-structure)
    - [Enable Show invisible characters](#enable-show-invisible-characters)
    - [Working with Images](#images)
    - [Footnotes: a caveat](#footnotes)
    - [Compiling Scrivener Comments](#scrivener-comments)
    - [Cross-referencing content](#cross-referencing)
* [Compiling in Scrivener via Pandoc](#compiling-your-project)
* [`scrivomatic` Compile Helper](#scrivomatic-post-processing-script)
* [More Writing Tips](#writing-tips-for-this-workflow)
    - [Use Custom Styles in Word and HTML](#how-to-use-custom-styles-in-word-and-html)
    - [Binding ⌘B etc. to Scrivener Styles](#binding-b-etc-to-scrivener-styles)
    - [Working with Bookends Reference Manager](#working-with-bookends-reference-manager)
    - [Minimal LaTeX Install Instructions](#minimal-latex-install)
* [Troubleshooting](#troubleshooting)

## Introduction ##

[Scrivener (macOS / Windows)](http://literatureandlatte.com) is a program for all types of writers, handling the structural organisation *and* constructive process of writing like nothing else. You write and manage text, ideas, figures and reference materials all in one place without having to worry about the final "look". The final "look" is handled by a process called compiling, where you choose the output format and select the contents with great flexibility. Though Scrivener uses rich text internally, it has excellent integration with plain text [markdown](https://en.wikipedia.org/wiki/Markdown). Compiling your Scrivener projects via markdown offers numerous advantages over rich text: it creates more structured, beautiful and flexible documents without lots of fussing in a Word processor or layout software. For example: 

* Binder headings are automatically converted into semantic heading levels (properly nested Headings 1-6).
* Figures *and* figure captions get proper styling.
* Semantically styled block quotes, code blocks (with *full syntax highlighting*), and many inline styles.
* Mathematical equations are properly parsed to many output formats.
* You can generate multiple outputs (PDF, LaTeX, DOCX, PPTX, ODT, EPub3, HTML etc.) simultaneously from a single compile; and trigger further tools to automate many workflows.
* You can use a Microsoft Word/LibreOffice source file to provide all page setup (paper size / modified headers & footers etc.) and fully customised styles without any fussing in a word processor afterwards.
* For academics, [Pandoc](http://pandoc.org/index.html) enables *generation of a full [Bibliography](http://pandoc.org/MANUAL.html#citations)* using thousands of available [publication styles](https://citationstyles.org/). 
* For technical writers, you can add semantic custom block and span structures (warning or info boxes for example).
* For LaTeX users, there is a lot of flexibility using rich templates and meta-data.

This all save you lots of time, especially if you compile regularly during collaborative editing.  

Because of [Pandoc's](http://pandoc.org/index.html) great flexibility, there are many possible settings to configure. To simplify this, you can run Pandoc using "template" tools like [Pandocomatic](https://heerdebeer.org/Software/markdown/pandocomatic/). For each document output, the template specifies all the options in Scrivener front-matter and/or a seperate configuration file. Pandocomatic templates allow you to run pre– and post–processors for more complex workflows (i.e. you could automate moving a HTML file to a web server after Scrivener compile). To use the Pandocomatic templates with Scrivener, you specify their name in the front–matter or metadata, and all the settings are automated when Pandoc is run.

**_UPDATE:_**: In Pandoc V2.8+, you can create "sets" of Pandoc options: [see some examples here](https://github.com/iandol/dotpandoc/tree/master/defaults). While I still prefer `pandocomatic` (described below) as I can use metadata, processor scripts and gain more control, I think this defaults system will be great for others who want a simpler setup. The workflow I use is just one of many ways of using Pandoc and Scrivener together.

### TL;DR (simple summary) ###
Scrivener already comes with the Multimarkdown tool, but in my opinion Pandoc provides many additional benefits and installation is quite simple. I use an additional tool Pandocomatic as a way to flexibly manage Pandoc settings directly within Scrivener.

1. Install the latest `pandoc` and `pandocomatic`.
2. Configure one or more pandocomatic "recipes"; you can base them on mine [shared below](#configuration).
3. In Scrivener, use a **front-matter** document containing the required settings and compile via the MultiMarkdown format (this option generates Pandoc output too). I offer a [compile format](https://raw.githubusercontent.com/iandol/scrivomatic/master/Scrivomatic.scrformat) for you to try.
4. Scrivener's compile post-processing triggers `pandocomatic`, **_automagically_** creating the final output(s) for you.

As a sample of the fuller workflow, you can download a [Scrivener project](https://raw.githubusercontent.com/iandol/scrivomatic/master/Workflow.scriv.zip) which bundles all the required files into the Binder (you  still need to install `pandoc` and `pandocomatic` first. See [the PDF/HTML/DOCX/TXT simultaneously-compiled final outputs here](https://github.com/iandol/scrivomatic/tree/master/sample-output)). 

To better understand the workflow outlined on this page, you should read at least sections **§21** and **§24** of the **Scrivener user manual**.

### Requirements ###

Apart from **Scrivener** (V3.x minimum required for this workflow), you should install **Pandoc** and **Pandocomatic**. This requires a small amount of typing into the [macOS terminal](https://support.apple.com/guide/terminal/welcome/mac). You can install `pandoc` [directly](http://pandoc.org/installing.html), but IMO it is better to use [Homebrew](https://brew.sh/) to install `pandoc`, as it can help keep everything up to date (`pandoc` receives regular automatic updates via homebrew). So first, follow the [instructions to install Homebrew](https://brew.sh/) ([info for the security conscious](https://discourse.brew.sh/t/security-issues-using-homebrew-malicious-insertion/3379)):

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

And then install `pandoc` using the `brew` command in the terminal:

```bash
brew install pandoc pandoc-citeproc pandoc-crossref
```

If you already installed `pandoc` manually, but want to use `brew` from now on, then you can use `brew link --overwrite ...` instead of `brew install ...`.

**macOS Mojave and earlier users:** the latest versions of Pandocomatic are not compatible with the ancient version of Ruby in macOS Mojave and earlier (macOS Catalina install a new version), and so you need to install a newer version of Ruby first. Read **_[Installing Ruby](https://github.com/iandol/scrivomatic/blob/master/Installing-Ruby.md)_** first for more details!

You use Ruby's `gem` command to install `pandocomatic` (if you are using macOS Catalina's built-in Ruby, you must put `sudo` at the start of the commands, if you used `brew` or `rbenv` to install Ruby, no `sudo` is required):

```bash
gem install pandocomatic 
```

To keep both Pandoc and Pandocomatic *up-to-date*, you can run the update commands like so every week or so:

```bash
gem update paru pandocomatic; brew upgrade
```


### Configuration ###

The most important folder for this workflow is the Pandoc data directory: **since Pandoc V2.7** it is `$HOME/.local/share/pandoc` (`$HOME` is your user directory, for example `/Users/johndoe/`; previous to V2.7 the folder was found at `$HOME/.pandoc`). Though not required, it is recommended to organise all your templates, filters and other files within this folder (pandocomatic uses the Pandoc data directory by default). To create your `$HOME/.local/share/pandoc` folder:  

```bash
> mkdir -p ~/.local/share/pandoc
```

All folders starting with a `.` are a hidden by default, but you can open them in Finder in two ways: 1) using the shortcut <kbd>⌘</kbd> + <kbd>SHIFT</kbd> + <kbd>G</kbd> and typing the path, in this case `~/.local/share/pandoc`; or 2) using the Terminal and typing:

```bash
> open ~/.local/share/pandoc
```

You can [explore my working Pandoc folder here](https://github.com/iandol/dotpandoc). It is comprised of a series of subfolders of files Pandoc and pandocomatic use during converison. You can *install* my Pandoc folder by [downloading it](https://github.com/iandol/dotpandoc/archive/master.zip) and unzipping its contents into your `$HOME/.local/share/pandoc`, or if you know how to use `git` you can just clone (or fork) it from Github.

`pandocomatic` uses a configuration file usually stored at the root of the Pandoc data directory: `$HOME/.local/share/pandoc/pandocomatic.yaml`. A simplified sample `pandocomatic.yaml` [is viewable here](https://github.com/iandol/scrivomatic/blob/master/pandocomatic.yaml); this won't work without customisation, but it gives you an idea of how pandocomatic-templates work ([full documentation here](https://heerdebeer.org/Software/markdown/pandocomatic/#pandocomatic-templates)). The basic idea is you create several pandocomatic-templates, and each pandocomatic-templates collects together a bunch of settings and configurations to produce a particular output. So I have `docx` pandocomatic-templates which is a basic Word conversion, but also a `docx-refs` which runs the bibliographic tools to generates a bibliography automatically for a docx file output.

For the rest of the files in the Pandoc data directory: all custom Pandoc templates reside in `$HOME/.local/share/pandoc/templates`, and [Pandoc filters](http://pandoc.org/filters.html) in `$HOME/.local/share/pandoc/filters`. For bibliographies, I symbolically link my Bibliography.bib into in `$HOME/.local/share/pandoc` and store my Journal style files in `$HOME/.local/share/pandoc/csl`. `pandocomatic` enables the use of pre– and post–processor scripts and these are stored in their own subfolders.

## Writing in Scrivener ##

With Scrivener 3's new [styles system (§15.5 user manual)](http://www.literatureandlatte.com/blog/?p=1094), there is a huge change to how you can write with markdown. You can use named paragraph styles (like "blockquote"), and named inline styles (like "emphasis" or "superscript") as you would writing in rich text (**i.e. there is _no need_ to add markdown syntax in the editor!**) With the [compile system (§23—user manual)](http://www.literatureandlatte.com/blog/?p=1097), Scrivener will add a prefix/suffix to create the required plain-text markdown. So for example, create an inline style called `Strong`, and in compile set the prefix to \*\* and suffix to \*\* and Scrivener automates conversion from the RTF style to markdown! You can even [rebind ⌘I and ⌘B](https://github.com/iandol/scrivomatic#binding-b-etc-to-scrivener-styles) to trigger the *Emphasis* and **Strong** styles directly. I use Scrivener styles to *visualise* structure **and** *generate* the Pandoc markup itself:  

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/Styles.png)
_Figure 1 — The cursor shows that both inline **Strong** and paragraph Caption styles are both active. Note whitespace is visualised and styles are used to give visual structure to the Scrivener writing environment. These will all be transformed into the correct markdown on compile…_

You can download my customised Scrivener 3 [compile preset here](https://raw.githubusercontent.com/iandol/scrivomatic/master/Scrivomatic.scrformat). Install it to get a flavour of how one can convert styles to markdown, and it now has the `scrivomatic` script built-in (needs Scrivener V3.03+).  

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/style-transform.png)
_Figure 2 — The Scrivener 3 Compile Format `Scrivomatic.scrformat` in the editor, showing how the inline style "Strong Emphasis" is converted into the correct markdown using prefix & suffix text. **IMPORTANT TIP: for block/paragraph styles you will need to enter newlines directly into the prefix/suffix edit fields; you do this using** <kbd>option</kbd> <kbd>return</kbd>._

### Enable Show invisible characters ###
Because markdown is sensitive to whitespace (double <kbd>return</kbd> to delineate paragraphs, 4 spaces/1 tab to delineate code blocks etc.), you should aim to use whitespace consistently: for new paragraphs and between any blocks of content [<kbd>space</kbd> <kbd>space</kbd> <kbd>return</kbd> <kbd>return</kbd>](http://pandoc.org/MANUAL.html#paragraphs) is optimal. Showing invisible characters in the Scrivener editor makes potential formatting issues when compiling simple to fix. Enable it using **`View ▶︎ Text Editing ▶︎ Show Invisibles`**, and change their colour in **`Preferences ▶︎ Appearance ▶︎ Textual Marks ▶︎ Invisible Characters`**. If you do not wish to use <kbd>return</kbd> <kbd>return</kbd> to delineate paragraphs in the Scrivener editor, you can use Scrivener's compile replacements, or **`Compile format Editor ▶︎ Transformations ▶︎ Convert to plain text ▶︎ Paragraph spacing`** (§24.13 user manual).

### Use the Binder for all document structure ###
Try not to not use markdown \# headings within text documents themselves but create documents at the correct level hierarchy in the Binder. Scrivener is great at compiling the levels of the Binder structure into the correct heading levels for you, and you benefit from being able to use the outlining and organisation tools within Scrivener.  

### Images ###
Scrivener can transform images that are embedded with a line of text (§21.4.1 user manual) into markup that generates proper semantic `<figure>` and `<figcaption>` elements. I now prefer to link images (Fig. 21.2—user manual) from the binder rather than by using the standard Pandoc markup: `![Figure caption](linked_image){.my_style}`; in both cases (embedded or linked-from-binder) Scrivener will correctly export the image file into the compile folder. Scrivener 3 has a nice new feature where you can binder-link figures (`Insert ▸ Image Linked to Document`), they are not embedded but still visible in the document, to add a caption to these you can use a caption style or \[\] brackets around the caption (described at the end of §21.4.1—user manual).  

### Footnotes ###
Scrivener will automatically convert footnotes into Markdown format for you. But there is one caveat in that you are not allowed to style footnotes, and so if you want to use *emphasis* / **strong** or other character styles, you will have to use the Pandoc formatting directly.  

### Scrivener Comments ###
Use comments and annotations freely. Scrivener 3 now allows you to transform comments to complex markup (§24.19.7—user manual) where the comment text `<$cmt>` AND the comment selection `<$lnk>` are both correctly exported). This can be set in `compile ▶︎ annotations…` — I use: `<span class="comment" title="<$cmt>"><$lnk></span>`. For export to DOCX, you can use `<span class="comment-start" id="<$n>" author="<$author>" date="<$date>"><$cmt></span><$lnk><span class="comment-end" id="<$n>"></span>`, which should transform into proper Word comments with using Pandoc 2+.  

### Cross-referencing ###
Out of habit I prefer Scrivener links when cross-reference documents / export figures, and Scrivener's placeholder tags to cross-reference figures and equations. But for new users Pandoc does have several cross-referencing filters ([pandoc-crossref](https://github.com/lierdakil/pandoc-crossref) and [pandoc-fignos](https://github.com/tomduck/pandoc-fignos) for example) and you can also use these. I have a quick [crossref.scriv](https://github.com/iandol/scrivomatic/blob/master/Crossref.scriv.zip) project available to show an example of using pandoc-crossref.


## Compiling your Project: ##
In Scrivener, I remove **all** compile–metadata specified in compile user interface ([see screenshot here](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/remove-metadata.png)) so it does not interfere with my custom metadata document. I create a document called something like **Pandoc metadata** containing the [YAML]() configuration block right at the top ([read more detailed documentation here](https://heerdebeer.org/Software/markdown/pandocomatic/#customizing-an-external-template-in-an-internal-template)). You can use Scrivener placeholder tags in this document (`Help ▸ List of All Placeholders…`). 

*  *  *  *
**_IMPORTANT_: Scrivener's autocorrect will "smarten" quotation marks and dashes and can capitalise keys like `title` or `pandocomatic`, which will cause problems for Pandocomatic and Pandoc so please check keys like `title`, `author` & `pandocomatic` are lowercase, straigten quotes and ensure the 3 hyphens are not converted into an em dash — also indentation in the metadata block must be *spaces* and not *tabs*.**

*  *  *  *

In the example YAML below, three templates are specified, so `pandocomatic` will run Pandoc three times to generate a DOCX, HTML and plain TXT file from the same single Scrivener compile:

```yaml
---
# Comment: make sure you use spaces not tabs, lower-case keys and straight quotes…
title: "<$projecttitle>"
author:
  - Joanna Doe
  - John Doe
keywords: 
  - test
  - pandoc
pandocomatic:
  use-template:
    - paper-with-refs-docx
    - paper-with-refs-html
    - paper-with-refs-text
---

```

The front matter should be the first document in the compile list and compiled **as–is**. 

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/as-is.png)
_Figure 3 — I created a `Project ▸ Project Settings… ▸ Section Type` called "Frontmatter", assigned this **Section Type** to 'Pandoc metadata', set 'Pandoc metadata' as Front Matter in the Compiler options, and then assigned it the AS-IS **Section Layout**._

The Pandocomatic configuration template (`pandocomatic.yaml`) could contain something like the example below for the DOCX template specified above (generating a bibliography using the APA style (with linked citations) and a table of contents):

```yaml
  paper-with-refs-docx:
    pandoc:
      from: markdown
      to: docx
      standalone: true
      filter: pandoc-citeproc
      bibliography: ./core.bib # ./ means same directory as markdown file
      citation-style: csl/apa.csl
      reference-docx: templates/custom.docx
      toc: true
    metadata: 
      notes-after-punctuation: false 
      link-citations: true
```

In Scrivener, you select Multimarkdown as the compile document output and select a compile format that configures a [post-processing tool](#scrivomatic-post-processing-script) to run pandocomatic automatically.

## Scrivomatic post-processing script ##

*You can run `pandocomatic` directly from Scrivener's post-processing panel*, but you may need to ensure the `Environment` path is set up so Scrivener can find all the files and the other tools properly. `Scrivomatic` is a small wrapper script ([yes, welcome to the rabbit hole 🙃](https://www.rousette.org.uk/archives/pandocomatic-and-scrivomatic/)!) that handles this for you…  

It adds the paths for tools installed via `homebrew`, `MacTeX` and `Cabal`; and if you've used [`rbenv`](https://github.com/rbenv/rbenv), [`rvm`](https://rvm.io/) or [`conda`](https://www.continuum.io/anaconda-overview) to install pandocomatic/panzer, it adds these paths too. It can also generate a detailed log file of the conversion (so you can check for missing references or other problems etc.). The easiest way to install it is to copy the raw code from here: [`scrivomatic`](https://github.com/iandol/scrivomatic/raw/master/scrivomatic), then you want to install it by pasting it into the Post-processing `Edit Script` edit field (leave Shell blank). You then configure the `Arguments` field (adding different flags to control `scrivomatic`, e.g. `-l` opens scrivomatic.log in Console automatically):

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/processing.png)
_Figure 4 — Scrivener's processing panel in the compile preset._

You can also download the script to your Downloads folder, move it to a directory on your path, and make sure it can be executed like so:

```bash
mkdir -p $HOME/bin
mv $HOME/Downloads/scrivomatic $HOME/bin
chmod 755 $HOME/bin/scrivomatic
```

You can then run `scrivomatic` from terminal with the following command line options:

```
Usage: scrivomatic [additional options] FILE
    -i, --input FILE                 Input file
    -o, --output [file]              Output file. Optional for pandocomatic.
    -t, --to [format]                Pandoc Format. Optional for pandocomatic.
    -y, --yaml [file]                Specify which YAML file for pandocomatic.
    -c, --command [command]          Tool to use: [pandocomatic] | panzer
    -p, --path [dirpath]             Additional Path to Search for Commands.
    -b, --build                      For LaTeX output, run latexmk
    -B, --buildclean                 For LaTeX output, run latexmk and cleanup
    -d, --dry-run                    Dry run.
    -z, --data-dir [file]            Pandoc data dir.
    -v, --[no-]verbose               Verbose output.
    -l, --[no-]log                   View log in Console.app.
    -h, --help                       Prints this help!
```

### Alfred Workflow ###

I also include an [Alfred workflow](https://raw.githubusercontent.com/iandol/scrivomatic/master/scrivomatic.alfredworkflow) so you can run `scrivomatic` directly from markdown files selected by Alfred:

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/3.png)
_Figure 5 — Alfred Workflow._

## Writing tips for this Workflow ##

### How-to use Custom Styles in Word and HTML ###
There are two recent features added to Pandoc, [Fenced Divs](http://pandoc.org/MANUAL.html#extension-fenced_divs) and [Custom Styles](http://pandoc.org/MANUAL.html#custom-styles-in-docx-output) (see also [bracketed spans](http://pandoc.org/MANUAL.html#extension-bracketed_spans)), that when combined, enable any arbitrary custom Scrivener paragraph or character styles to be converted into Word styles or CSS classes. So for example, we can create an "Allegory" paragraph style in Scrivener, and in the Compiler style we use the fenced div syntax prefix=`\n::: {custom-style="Allegory"} :::\n` & suffix=`\n:::\n` (`\n` means enter a return, done using `option+return` in the edit box) which would generate a fenced div like so in the compiled Pandoc file:

~~~markdown
::: {custom-style="Allegory"} :::
All animals are equal but a few are more equal than others
:::
~~~

Pandoc will then attach a word style named "Allegory" to that paragraph in the output DOCX. You can either edit the style in Word, or [edit your reference.docx to include this custom style](http://pandoc.org/MANUAL.html#custom-styles-in-docx-output), so it already styled when you open the DOCX.

### Binding ⌘B etc. to Scrivener Styles ###
Most people have ⌘B & ⌘I key bindings well memorised for bold and italic. A cool thing about Scrivener Styles and macOS is you can rebind these keys so they toggle the **Strong** and *Emphasis* styles rather than bold and italic itself. To do this you go to `System Preferences ▸ Keyboard ▸ Shortcuts`, click the [+] button, select Scrivener.app and enter the name and key to make the following:

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/macOS-Keys.png)
_Figure 6 — Rebinding macOS keys to use Scrivener Styles._

In the case of `Strong` and `Emphasis`, there is no need to enter the full menu path to the Style as the names are unique, but you can also use the complete `Format->Style->Emphasis` to make this entry explicit. More general instructions from Literature & Latte are [available here](https://scrivener.tenderapp.com/help/kb/macos/assigning-or-changing-keyboard-shortcuts-in-scrivener-for-mac). A 3rd-party tool that provides key rebinding and an incredible amount of additional control is [BetterTouchTool](https://folivora.ai). You would remap the keys in the following way in BTT:

![](https://raw.githubusercontent.com/iandol/scrivomatic/master/images/BTT.png)
_Figure 7 — Rebinding macOS keys to Scrivener Styles in BTT._

### Working with Bookends Reference Manager ###
[Bookends](http://www.sonnysoftware.com/) is an excellent reference manager for macOS which can be configured to output temporary citations for Scrivener in a format fully compatible with Pandoc. To set this up I'd first follow the excellent tutorial here:

[BSAG » Bookends and Pandoc](https://www.rousette.org.uk/archives/bookends-and-pandoc/)

To export your references as a file Pandoc can read (usually a BibTeX file) you can do tht manually from the Bookends GUI. However, you can do this automatically every day or so using [this applescript](https://raw.githubusercontent.com/iandol/bookends-tools/master/source/toBibTeX.applescript), you can specify an output folder and comma-separated list of groups via command-line input. This script can also be run directly from [Bookends Tools for Alfred](https://github.com/iandol/bookends-tools). I would recommend setting the option to save a JSON instead of BibTeX as Pandoc parses the JSON ~3X faster when processing documents, and with a big reference database that can save quite a lot of time!

### Minimal LaTeX Install ###
I prefer to use the minimal LaTeX installer found here: [BasicTeX Installer](http://www.tug.org/mactex/morepackages.html) (can install with brew: `brew cask install basictex`) — and for Pandoc's templates to work I've determined the following additional packages are needed (installed easily with the command line tool `tlmgr` that comes with TeX, or with [TeX Live Utility](http://amaxwell.github.io/tlutility/)):

~~~bash
sudo tlmgr install lm-math lualatex-math luatexja abstract \
latexmk csquotes pagecolor relsize ucharcat mdframed needspace sectsty \
titling titlesec preprint layouts glossaries tabulary soul xargs todonotes \
mfirstuc xfor wallpaper datatool substr ctablestack ifetex adjustbox collectbox \
footnotebackref fvextra
~~~

## Troubleshooting ##
* If you only get a HTML file out, it normally means that pandocomatic could not read the metadata or find the `pandocomatic.yaml` file. Make sure you have the Pandoc Data Directory properly set up, that your metadata at the top of the compiled markdown looks correct, and check for errors in the `scrivomatic.log` file that you should get every time you compile in Scrivener.
* YAML metadata can be a bit fussy: 
  - Metadata keys are **lowercase**: *title* **not** *Title*, *pandocomatic* **not** *Pandocomatic* etc.
  - You **must** use spaces for indentation, not tabs.
  - You should use "straight" not “curly” quotes for strings (use Scrivener's straighten quotes function).
  - Strings don't strictly need to be quoted, but it is normally safer (for example if there is a colon in the string you must quote). 
  - You can [validate your YAML online here](http://www.yamllint.com/), and read a [quick tutorial of YAML here](https://learnxinyminutes.com/docs/yaml/).
* I use a Meta-data paragraph style to wrap `---` around the Pandoc metadata front-matter, but you can just put it directly in the front matter yourself. Which ever way you do it, without `---` around the metadata it will **not** be recognised, and you will again get a simple HTML output file.
* Make sure there are no `.ruby-version` config files used by rbenv in the compile folder, or if there are that they are configured to use the correct Ruby version with pandocomatic installed...
