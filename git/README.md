# Git

Configuration for [Git](https://git-scm.com/doc).

## Installation

Comes with macOS, but the bundled version is often outdated. Homebrew keeps it current:

```sh
brew install git
```

## Files

- `.gitconfig` — main configuration
- `.gitignore` — global ignore patterns (`*~`, `.DS_Store`, `tags`, `.vim/`)

## Notable settings

- **Pager**: [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) (`brew install diff-so-fancy`)
- **Editor**: `nvim`
- **Pull**: fast-forward only
- **Push**: auto setup remote

## Custom aliases

| Alias | Description |
|-------|-------------|
| `graph` | Pretty `git log` with graph and colors |
| `submodule-add-ignore` | Add a submodule and set `ignore = all` — keeps `git status` clean by hiding submodule changes |
| `submodule-purge` | Completely remove a submodule — automates the multi-step deinit/rm process |
| `subdirs` | Run a git command in all sub-directory repos — useful for bulk status checks or pulls |
| `subdirs-p` | Same as `subdirs` but in parallel — faster for slow operations like fetch |
