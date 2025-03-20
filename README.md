# modille's dotfiles

## Requirements

### 1Password

Setup and sign in to [1Password](https://1password.com/downloads), and install the [1Password CLI](https://developer.1password.com/docs/cli/get-started).

Verify it works:

```sh
op signin
op vault list
```

### Xcode Command Line Tools

Request install with:

```sh
xcode-select –-install
```

Then click **Install** on the pop-up.

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

In iTerm2 settings, go to **Profiles** then choose **Import JSON Profiles** and browse to the `~/.local/share/chezmoi/Profiles.json` file.

## Daily operations

Set up pre-push hook to check for secrets:

```sh
./setup_git_hooks.sh

# Test it out once
./.git/hooks/pre-push
```

Review what changes `chezmoi apply` would make:

```sh
chezmoi diff
```
