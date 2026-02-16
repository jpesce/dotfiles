<p align="center">
  <h1 align="center">tmux</h1>
</p>

Configuration for [tmux](https://github.com/tmux/tmux).

## Installation

```sh
brew install tmux
```

## Prefix key

<kbd>Ctrl</kbd>+<kbd>Space</kbd> (remapped from default <kbd>Ctrl</kbd>+<kbd>B</kbd>)

## Key bindings

### Windows

| Key | Action |
|-----|--------|
| <kbd>Prefix</kbd> <kbd>c</kbd> | New window (same directory) |
| <kbd>Option</kbd>+<kbd>Shift</kbd>+<kbd>H</kbd> | Previous window |
| <kbd>Option</kbd>+<kbd>Shift</kbd>+<kbd>L</kbd> | Next window |

### Panes

| Key | Action |
|-----|--------|
| <kbd>Prefix</kbd> <kbd>\|</kbd> | Split vertically (same directory) |
| <kbd>Prefix</kbd> <kbd>-</kbd> | Split horizontally (same directory) |
| <kbd>Option</kbd>+<kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> | Navigate panes (vim-aware) |
| <kbd>Prefix</kbd> <kbd>Ctrl</kbd>+<kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> | Resize panes |

### Other

| Key | Action |
|-----|--------|
| <kbd>Prefix</kbd> <kbd>r</kbd> | Reload config |
| <kbd>Prefix</kbd> <kbd>S</kbd> | Toggle pane synchronization |
| <kbd>v</kbd> / <kbd>y</kbd> | Visual select / yank (copy mode) |

## Status bar

- Position: top
- Left: indicators for leader key (`⎵`), zoom (`⤢`), pane sync (`↹`)
- Right: git branch name

## Session templates

Predefined session layouts in `sessions/`:

- `golden_ratio_split.sh`
