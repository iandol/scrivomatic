---
layout: page
title: "Installing Ruby"
permalink: /installing-ruby/
---

# Installing Ruby  

Versions of pandocomatic since V0.2.4.1 do not support the *ancient* version of Ruby (V2.3.7) that comes by default with macOS versions **before** macOS Catalina (10.15). 

Below are a series of options to get ruby installed. **_Remember_**: these should be considered mutually exclusive, choose either Catalina's system ruby, `rbenv` **OR** homebrew's Ruby, do not mix them together…


## Users on macOS Catalina and later ««simple»»
If you are using macOS Catalina / Big Sur / Monterey, then you have V2.6.x of Ruby already and installing pandocomatic is as simple as typing this into Terminal (you don't need to use `-n /usr/local/bin/` like before, it is the default):

```shell
sudo gem install paru pandocomatic
```

I still prefer `rbenv` as it makes updating and managing ruby easier (see below)...

## Users on older macOS versions ««downgrade»»

So the first simplest solution is to deliberately install an older version of pandocomatic:

```shell
 sudo gem install paru:0.3.1.0 pandocomatic:0.2.4.0 -n '/usr/local/bin'
 ```

…but this will *not* include any bug fixes or optimisations for new versions of Pandoc going forwards and IMO installing a modern version of Ruby is a much better option.

## Using rbenv ««best long-term solution IMO»»

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
rbenv install 3.1.2
rbenv global 3.1.2
gem install paru pandocomatic
```

`rbenv` adds a single directory (`~/.rbenv/shims/`) that scrivomatic adds to the path searched when Scrivener triggers the post-processing. This is what I personally use and so is the best supported option for the `scrivomatic` script.

There is a [default-gems plugin](https://github.com/rbenv/rbenv-default-gems), so you can add `pandocomatic` to your default gems and whenever a new version of Ruby is installed by rbenv, pandocomatic will also be set up 😎.

### Using brew to install ruby ««less flexible»»

You can also install Ruby directly with [Homebrew](https://brew.sh/):

```shell
brew install ruby
```

By default, `brew` does not add this Ruby to the path as it assumes the System Ruby should take priority, but as we know `pandocomatic` is not compatible with the system Ruby in macOS < 10.15. So you can ensure `brew`'s Ruby is used by putting its folders first in the path with this command:  

```shell
echo '\nexport PATH="/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
```

Or if you use zsh:  

```shell
echo '\nexport PATH="/usr/local/lib/ruby/gems/2.7.0/bin:/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
```

You must then restart your terminal so the path takes effect. Then you can install `pandocomatic`:  

```shell
gem install pandocomatic
```

Personally I'm not a big fan of this method as you will need to manually update the path for new Ruby versions, and you can't switch version quickly like `rbenv`.

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


