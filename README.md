# modille's dotfiles

![editor](https://raw.githubusercontent.com/modille/modille.github.io/master/images/modille-dotfiles-editor.png)

![zsh](https://raw.githubusercontent.com/modille/modille.github.io/master/images/modille-dotfiles-zsh.png)

## Requirements

Set zsh as your login shell:

```sh
chsh -s $(which zsh)
```

## Install

Clone into `~/dotfiles`:

```sh
git clone git://github.com/modille/dotfiles.git ~/dotfiles
```

Install [rcm](https://github.com/thoughtbot/rcm):

```sh
brew tap thoughtbot/formulae
brew install rcm
```

Install the dotfiles:

```sh
env RCRC=$HOME/dotfiles/rcrc rcup
```

After the initial installation, you can run `rcup` without the one-time variable `RCRC` being set.
This command will create symlinks for config files in your home directory.

You can safely run `rcup` multiple times to update:

```sh
rcup
```

You should run `rcup` after pulling a new version of the repository to symlink any new files in the repository.
