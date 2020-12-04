# Installing Ruby  

Versions of pandocomatic since V0.2.4.1 do not support the *ancient* version of Ruby (V2.3.7) that comes by default with macOS versions **before** macOS Catalina (10.15). 

Below are a series of options to get ruby up and running. **_Remember_**: these should be considered mutually exclusive, choose either Catalina's system ruby, `rbenv` **OR** homebrew's Ruby, do not mix them together…


## Users on macOS Catalina and Big Sur ««simple»»
If you are using macOS Catalina or Big sur, then you have V2.6.3 of Ruby already and installing pandocomatic is as simple as typing this into Terminal (you don't need to use `-n /usr/local/bin/` like before, it is the default):

```shell
sudo gem install paru pandocomatic
```

I still prefer `rbenv` as it makes updating and managing ruby easier (see below)...

## Users on older macOS versions ««downgrade»»

So the first simplest solution is to deliberately install an older version of pandocomatic:

```shell
 sudo gem install paru:0.3.1.0 pandocomatic:0.2.4.0 -n '/usr/local/bin'
 ```

…but this will not include any bug fixes going forwards and IMO installing a modern version of Ruby is a much better option.

## Using rbenv ««best long-term solution IMO»»

[rbenv](https://github.com/rbenv/rbenv) allows *multiple* ruby versions to run easily side-by-side and handles all the path changes for you, but is a bit more involved to use. First install with [Homebrew](https://brew.sh/):

```shell
brew install rbenv
rbenv init
```

The [instructions](https://github.com/rbenv/rbenv#homebrew-on-macos) tell you to add `eval "rbenv init -"` in your `.bash_profile` or `.zshrc`, so you can do this using the following command (replace `.bash_profile` with `.zshrc` if you use `zsh`):

```shell
echo '\neval "$(rbenv init -)"' >> ~/.bash_profile
```

Restart your terminal to trigger this adjustment, then install a modern ruby and finally pandocomatic:

```shell
rbenv install 2.7.1
rbenv global 2.7.1
gem install pandocomatic
```

`rbenv` adds a single directory (`~/.rbenv/shims/`) that scrivomatic adds to the path searched when Scrivener triggers the post-processing. This is what I use and so is the best supported option.

There is a [default-gems plugin](https://github.com/rbenv/rbenv-default-gems), so you can add pandocmatic to your default gems and whenever a new version of Ruby is installed by rbenv, pandocomatic will already be set up.

### Using brew to install ruby ««less flexible»»

You can also install Ruby directly with [Homebrew](https://brew.sh/):

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

Personally I'm not a big fan of this method as you will need to manually update the path, when for example Ruby V2.8 gets released, and you can't switch ruby version quickly like you can with `rbenv`.

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
 rbenv global 2.7.1; rbenv shell 2.7.1
 gem install -f paru pandocomatic
```


