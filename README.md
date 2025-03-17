# modille's dotfiles

## Requirements

Setup and sign in to 1Password, and install the 1Password CLI.

## Install

Download [chezmoi](https://www.chezmoi.io):

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
```

Clone this repo to setup the source directory:

```sh
./bin/chezmoi init https://github.com/modille/dotfiles.git
```

You can then see what would be changed:

```sh
./bin/chezmoi diff
```

If you're happy with the changes then apply them:

```sh
./bin/chezmoi apply --verbose
```

After this, `chezmoi` will be available without needing the local binary.

A restart will be required for macOS defaults changes to take effect.

## Daily operations

```sh
chezmoi diff
```
