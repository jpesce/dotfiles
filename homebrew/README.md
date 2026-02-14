# Homebrew

Programs managed by [Homebrew](https://brew.sh/) and [mas](https://github.com/mas-cli/mas) are listed in Brewfiles ([see docs](https://docs.brew.sh/Brew-Bundle-and-Brewfile)).

- [Brewfile.manual](./Brewfile.manual) — curated, categorized and annotated list of programs
- [Brewfile.auto](./Brewfile.auto) — automatically updated at every install and uninstall (see [homebrew.zsh](../zsh/.zsh/modules/homebrew.zsh))

Run `./report.sh` to spot differences between them and decide if we need to install, uninstall or add any programs to `Brewfile.manual`.

## Usage

**Install everything from a Brewfile**
```sh
brew bundle install --file <Brewfile>
```

**Remove anything not listed in Brewfile**
```sh
brew bundle cleanup --file <Brewfile>
```

**Update Brewfile with current installs**
```sh
brew bundle dump --force --file <Brewfile>
```
