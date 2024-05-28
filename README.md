# Fish Shell Dev Tools

A collection of Fish shell functions useful for software development on Linux

## Prerequisites

Install the following before use:

 - [fd-find](https://github.com/sharkdp/fd)
 - *[glow](https://github.com/charmbracelet/glow)

 * alternatively you can set MARKDOWN_RENDERER to another command to show markdown file contents. You can even set it to "cat"

## Usage

```bash
set DEV_COMMAND_HELP path/to/commands.md
source dev.fish
list_dev_commands
```

## Installation

**Edit** `~/.config/fish/config.fish`

```bash
# Optionally add: set -e MARKDOWN_RENDERER "cat"
set DEV_COMMAND_HELP path/to/commands.md
source ~/path/to/dev.fish
```

## Commands

[Commands](commands.md)