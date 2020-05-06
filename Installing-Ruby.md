# Installing Ruby  

Recent versions of pandocomatic (0.2.4.1+) have broken compatibility with the *ancient* version of Ruby (V2.3.7) that comes by default with macOS versions **before** macOS Catalina (10.15). 


## Users using macOS Catalina
If you are using macOS Catalina, then you actually have V2.6.3 of Ruby and installing pandocomatic is as simple as typing this into Terminal (you don't even need to use `-n /usr/local/bin/` like before, it is the default):

```shell
sudo gem install paru pandocomatic
```

Sadly, this new version of Ruby will be removed in macOS 10.16 next year, but for the moment Catalina users have a simple solution.

## Users using older macOS versions

So the first simplest solution is to deliberately install an older version of pandocomatic:

```shell
 sudo gem install paru:0.3.1.0 pandocomatic:0.2.4.0 -n '/usr/local/bin'
 ```

…but this will not include any bug fixes going forwards and IMO installing a modern version of Ruby is a much better option.

### Using rbenv…  

[rbenv](https://github.com/rbenv/rbenv) allows multiple ruby versions to run side-by-side and handles the path changes for you, but is a bit more involved to install:

```shell
brew install rbenv
rbenv init
```

The [instructions](https://github.com/rbenv/rbenv#homebrew-on-macos) tell you to add `eval "rbenv init -"` in your `.bash_profile` or `.zshrc`, so you can do this using the following command (replace `.bash_profile` with `.zshrc` if you use `zsh`):

```shell
echo '\neval "$(rbenv init -)"' >> ~/.bash_profile
```

Restart your terminal, then install a modern ruby, and finally pandocomatic:

```shell
rbenv install 2.7.1
rbenv global 2.7.1
gem install pandocomatic
```

`rbenv` adds a single directory that scrivomatic adds to the path that is searched when Scrivener triggers the post-processing.

### Using Homebrew…  

You can also install Ruby directly with [Homebrew](https://brew.sh/), which I've already recommended for installing Pandoc, and which quickly installs the latest Ruby version:

```shell
brew install ruby
```

By default, `brew` does not add this Ruby to the path as it assumes the System Ruby should take priority, but as we know pandocomatic is not compatible with the system Ruby in macOS < 10.15. So you can ensure `brew`'s Ruby is used by putting its folders first in the path with this command:  

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

Personally I'm not a big fan of this method as you will need to manually update the path, when for example Ruby V2.8 gets released. 

## Troubleshooting…

A couple of users have recently tried to install pandocomatic via rbenv, and have had a conflict with other versions of the gems; if this is a problem for you try the following:

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
 rbenv global 2.6.3; rbenv shell 2.6.3 
 gem install -f paru pandocomatic
```


