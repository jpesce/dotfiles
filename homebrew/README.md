Programs managed by Homebrew and [mas](https://github.com/mas-cli/mas) are
listed in the [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile).

# Usage

Run these commands from the `homebrew` directory (or use `--file` to specify
the path to it).

**Update `Brewfile` with current installs**
```sh
brew bundle dump --force
```

**Install everything from `Brewfile`**
```sh
brew bundle install
```

**Remove anything not listed in `Brewfile`**
```sh
brew bundle cleanup
```
