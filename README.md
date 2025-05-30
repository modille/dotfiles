# modille's dotfiles

## Requirements

### 1Password

Setup and sign in to [1Password](https://1password.com/downloads), and install the [1Password CLI](https://developer.1password.com/docs/cli/get-started).

Verify it works:

```sh
op vault list
```

### Xcode Command Line Tools

Request install with:

```sh
xcode-select –-install
```

Then click **Install** on the pop-up and restart after it finishes installing.

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

Change the git remote from HTTPS to SSH to be able to push/fetch.

```sh
cd ~/.local/share/chezmoi
git remote set-url origin git@github.com:modille/dotfiles.git
```

And set up a pre-push hook to check for secrets:

```sh
./setup_git_hooks.sh

# Test it out once
./.git/hooks/pre-push
```

## Manual configuration

Sometimes we just can't have nice things...

### iTerm2

Install Rosetta (seems to be a requirement for Python API scripts):

```sh
/usr/sbin/softwareupdate --install-rosetta
```

Then open iTerm2 and:

1. Sync settings from `~/.local/share/chezmoi` and save changes automatically. Don't copy current settings.
1. Import profiles from `~/.local/share/chezmoi/Profiles.json` then change the default profile.
1. Verify **Scripts** > **AutoLaunch** has `dark_mode_notify.py` and click on it once to enable the Python API.
1. Go to **Scripts** > **Manage** > **Manage dependencies** and click the **Update** button

### Dropbox

Sign in to Dropbox and then go to **Preferences** > **Sync** and choose **Dropbox for File Provider**.
Wait for the updated sync to finish.

### Rectangle

Import settings from `~/.local/share/chezmoi/RectangleConfig.json`

### Alfred

Disable the Spotlight keyboard shortcut under `System Settings > Keyboard > Keyboard shortcuts > Spotlight`.

Sign in to Dropbox and wait for it to sync.
The Alfred preferences file is large, so it's nicer to be synced from there instead.

Afterwards, set Alfred preferences folder to `~/Dropbox/dotfiles`

### fish history

Manually sync `~/.local/share/fish/fish_history` from another host.

If your username changed, then use something like this:

```sh
cp fish_history new_fish_history
sed -i '' 's#/Users/modille#/Users/odillem#g' new_fish_history
```

### Dash

Sign in to Dropbox and wait for it to sync.
The Dash preferences file changes timestamps all the time, so it's nicer to be synced from there instead.

Afterwards, set sync folder to `~/Dropbox/dotfiles/Dash`

You can automate installing new docsets (based on project dependencies, for example) with something like <https://gist.github.com/modille/e406e3de928730529e298cfee6b3c772>.

### Tuple

#### Hang up Tuple call when joining a non-Tuple call

In Tuple, set hotkey `Command-Option-T` to hang up the call.

Then create a "Tuple Hang Up" macOS Shortcut to Run AppleScript that presses the hotkey:

```scpt
on run {input, parameters}
	tell application "System Events"
		key down option
		key down command
		keystroke "t"
		key up option
		key up command
	end tell

	return input
end run
```

Then in Dato, run the Tuple Hang Up shortcut when joining a video call.

### JetBrains

Change the following settings:

- Use the same language for all tools
- Region
- Update all tools automatically
- Keep previous versions of tools to enable instant rollback
- Generate shell scripts
- Display build numbers for installed tools

Then add scripts to PATH:

```sh
fish_add_path ~/Library/Application\ Support/Jetbrains/Toolbox/scripts
```

Quit IntelliJ and then you can install plugins from the command line:

```sh
idea installPlugins "Key Promoter X"
idea installPlugins aws.toolkit
idea installPlugins aws.toolkit.core
idea installPlugins com.chylex.intellij.inspectionlens
idea installPlugins com.github.bufbuild.intellij
idea installPlugins com.github.catppuccin.jetbrains
idea installPlugins com.intellij.exposed
idea installPlugins com.nbadal.ktlint
idea installPlugins eu.theblob42.idea.whichkey
idea installPlugins net.ashald.envfile
idea installPlugins org.sonarlint.idea

# Nyan Progress Bar
idea installPlugins some.awesome

# Terraform and HCL
idea installPlugins org.intellij.plugins.hcl

# Last, but not least <3
idea installPlugins IdeaVIM
```

## Daily operations

Review what changes `chezmoi apply` would make:

```sh
chezmoi diff
```

Merge current state with chezmoi state:

```sh
# Use nvim for 3-way diff
echo "" >> "$HOME/.config/chezmoi/chezmoi.toml" && \
echo "[merge]" >> "$HOME/.config/chezmoi/chezmoi.toml" && \
echo "    command = \"nvim\"" >> "$HOME/.config/chezmoi/chezmoi.toml" && \
echo "    args = [\"-d\", \"{{ .Destination }}\", \"{{ .Source }}\", \"{{ .Target }}\"]" >> "$HOME/.config/chezmoi/chezmoi.toml"

chezmoi merge
```

Quickly switch to chezmoi directory:

```sh
chezmoi cd
```
