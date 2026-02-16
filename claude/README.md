<p align="center">
  <h1 align="center">Claude Code</h1>
</p>

Configuration for [Claude Code](https://docs.anthropic.com/en/docs/claude-code), Anthropic's CLI for Claude.

## Installation

```sh
brew install claude-code
```

## Structure

Files in this directory are symlinked to `~/.claude/` via dotbot:

- `settings.json` — permissions and preferences
- `keybindings.json` — custom keyboard shortcuts
- `CLAUDE.md` — project instructions
- `agents/` — custom agent definitions
- `commands/` — custom slash commands
- `skills/` — custom skills
- `rules/` — custom rules

See the [official docs](https://docs.anthropic.com/en/docs/claude-code) for details on each configuration file.
