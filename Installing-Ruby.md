# Installing Ruby #

Recent versions of pandocomatic (0.2.4.1+) have broken compatibility with the *ancient* version of Ruby (V2.3.7) that comes with macOS. There are several easy ways to install modern versions of Ruby. 

## Use Homebrew ##

The first is to use [Homebrew](https://brew.sh/), which I already recommend for installing Pandoc and which quickly installs the latest Ruby version:

```shell
> brew install ruby
```

By default, brew does not add this Ruby to the path, as it assumes the System Ruby should take priority, **BUT** pandocomatic is not compatible with the system Ruby. You can ensure brew's Ruby gets used by putting it in your path with this command:  

```shell
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bashrc
```

Or if you use zsh then use `echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc`. You must then restart your terminal so the path takes effect, then you can install `paru` and `pandocomatic` (you don't need `-u` as you needed for the system Ruby):

```
> gem install paru pandocomatic
```

## Use rbenv ##

rbenv allows multiple ruby versions to run side-by-side, and easily switched between, but is a bit more involved and requires more manual maintainence:

```shell
> brew install rbenv
> rbenv install 2.6.2
> rbenv global 2.6.2
> gem install paru pandocomatic
```

