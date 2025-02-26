---
layout: page
title: "Installing Ruby"
permalink: /installing-ruby/
---

# Installing Ruby for Pandocomatic in 2025

Pandocomatic V2.0+ currently requires Ruby V3.1 or later. The system Ruby in macOS is V2.6.10, therefore you must either downgrade to an old version of pandocomatic (not recommended, you will also need to downgrade to older pandoc probably), or make sure you are running a newer Ruby (V3.4x as of this writing). 

Below are a series of options to get ruby installed. **_Remember_**: these should be considered mutually exclusive, choose either `rbenv` **OR** `pixi` **OR** homebrew's Ruby, *do not mix them together*…

## Using Homebrew ««less flexible»»

You can install Ruby with [Homebrew](https://brew.sh/):

```shell
> brew info ruby
> brew install ruby
```

By default, `brew` does **not add this Ruby to the user path** as it assumes the System Ruby should take priority, but as we know `pandocomatic` is not compatible with the system Ruby in macOS < 10.15. So you should ensure `brew`'s Ruby is used by putting its folders first in the path with this command for Apple Silicon: 

```shell
> echo 'export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
```

You must then restart your terminal so the path takes effect. Then you can install `pandocomatic` using `gem install pandocomatic`. Note when Ruby updates to a new major version, you also need to update the path entry as `3.4.0` is hardcoded there.

## Using pixi <https://pixi.sh>

Pixi is a new cross-platform package manager that uses conda as its package source. The command is easy to install and packages are easy to manage:

Install pixi (also make sure `zsh` gem path will be added).

```shell
> curl -fsSL https://pixi.sh/install.sh | bash
> echo 'export PATH="$HOME/.pixi/envs/ruby/share/rubygems/bin:$PATH"' >> ~/.zshrc
```

Restart your terminal, then:

```shell
> pixi global install ruby --with compilers
> gem install pandocomatic
```

You can also add other tools like Pandoc, Typst:

```
> pixi global install pandoc typst librsvg
```

You can keep pandocomatic and all other tools up-to-date:

```shell
> gem update
> pixi global update
```

## Using rbenv 

[rbenv](https://github.com/rbenv/rbenv) allows *multiple* ruby versions to run easily side-by-side and handles all the path changes for you, but is a bit more involved to use. First install with [Homebrew](https://brew.sh/):

```shell
brew install rbenv
rbenv init
```

The [instructions](https://github.com/rbenv/rbenv#homebrew-on-macos) tell you to add `eval "rbenv init -"` in your `.zshrc` or `.bash_profile`, so you can do this using the following command (replace `.zshrc` with `.bash_profile` if you still use `bash`):

```shell
echo '\neval "$(rbenv init -)"' >> ~/.zsh
```

Restart your terminal to trigger this adjustment, then install a modern ruby (you can see a list with `rbenv install -l`) and finally pandocomatic:

```shell
rbenv install 3.2.0
rbenv global 3.2.0
gem install paru pandocomatic
```

`rbenv` adds a single directory (`~/.rbenv/shims/`) that scrivomatic adds to the path searched when Scrivener triggers the post-processing. This is what I personally use and so is the best supported option for the `scrivomatic` script.

There is a [default-gems plugin](https://github.com/rbenv/rbenv-default-gems), so you can add `pandocomatic` to your default gems and whenever a new version of Ruby is installed by rbenv, pandocomatic will also be set up 😎.

## Troubleshooting…

### Gem Conflicts
A couple of users have  tried to install pandocomatic via rbenv, and have had a conflict with other versions of the gems on the same system (this shouldn't happen, and it is probably a bug that may be already fixed); if this is a problem for you try the following:

1. Switch to system ruby:
```shell
rbenv global system; rbenv shell system
```
2. Uninstall system versions:
```shell
 sudo gem uninstall -f paru pandocomatic -n '/usr/local/bin' 
```
3. Switch back to the modern Ruby and force install latest paru and pandocomatic
```shell
 rbenv global 3.0.0; rbenv shell 3.0.0
 gem install -f paru pandocomatic
```


