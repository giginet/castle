# giginet dotfiles

A repository for storing dotfiles. Files under `home/` are symlinked to `~/`.

Limit operations to within this repository only. Do not directly manipulate the home directory.

## homeshick

This repository uses homeshick to manage dotfiles. With this tool, all dotfiles unde `.home` have to be linked from the home dir. For example `.home/.zshrc` will be symlinked to `~/.zshrc`, and so on. To add a new file, add it to the `home/` directory and run `homeshick symlink castle`.

## Claude Code Development

Claude Code configuration files are stored under `.claude`. The plugin-dev plugin is enabled in this repository, so use skills like skill-development for development.
