# Karabiner

Configuration for [Karabiner-Elements](https://karabiner-elements.pqrs.org/), a keyboard customizer for macOS.

## Installation

```sh
brew install --cask karabiner-elements
```

## Key mappings

Remaps <kbd>Caps Lock</kbd> into a modifier layer:

| Key | Action |
|-----|--------|
| <kbd>Caps Lock</kbd> (tap) | <kbd>Esc</kbd> |
| <kbd>Caps Lock</kbd>+<kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> | Arrow keys (vim-style) |
| <kbd>Caps Lock</kbd>+<kbd>[</kbd> | <kbd>Esc</kbd> |
| <kbd>Caps Lock</kbd>+<kbd>Enter</kbd> | Toggle Caps Lock |
| <kbd>Caps Lock</kbd> (held too long) | Nothing |

## Setup

After [installing the dotfiles](../README.md), open Karabiner and navigate to
`Complex Modifications > Add predefined rules`, then enable the desired options:

<img width="1212" alt="add-predefined-rules"
src="https://github.com/user-attachments/assets/c0b27cc7-7492-4720-bea7-99d06d79bf57"
/>
