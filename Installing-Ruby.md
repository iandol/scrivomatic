# Installing Ruby  

Recent versions of pandocomatic (0.2.4.1+) have broken compatibility with the *ancient* version of Ruby (V2.3.7) that comes by default with macOS. One solution is to install an older version of pandocomatic (`gem install pandocomatic -v 0.2.4.0`), but I think installing a modern versions of Ruby is the better option. 

## Using Homebrew…  

The easiest way to install a modern Ruby version is to use [Homebrew](https://brew.sh/), which I already recommend for installing Pandoc and which quickly installs the latest Ruby version:

```shell
brew install ruby
```

By default, `brew` does not add this Ruby to the path as it assumes the System Ruby should take priority, but as we know pandocomatic is not compatible with the system Ruby. So you can ensure `brew`'s Ruby is used by putting its folders first in the path with this command:  

```shell
echo '\nexport PATH="/usr/local/lib/ruby/gems/2.6.0/bin:/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
```

Or if you use zsh:  

```shell
echo '\nexport PATH="/usr/local/lib/ruby/gems/2.6.0/bin:/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
```

You must then restart your terminal so the path takes effect. Then you can install `pandocomatic`:  

```shell
gem install pandocomatic
```

## Using rbenv…  

[rbenv](https://github.com/rbenv/rbenv) allows multiple ruby versions to run side-by-side, but is a bit more involved to install:

```shell
brew install rbenv
rbenv init
```

The [instructions](https://github.com/rbenv/rbenv#homebrew-on-macos) tell you to add `eval "rbenv init -"` in your `.bash_profile` or `.zshrc`, so you can do this using the following command (replace `.bash_profile` with `.zshrc` if you use `zsh`):

```shell
echo '\neval "$(rbenv init -)"' >> ~/.bash_profile
```

Restart your terminal, then install a modern ruby version, and finally pandocomatic:

```shell
rbenv install 2.6.2
rbenv global 2.6.2
gem install pandocomatic
```
