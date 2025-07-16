# Overview

The scripts in the descriptions below (as well as all the scripts in the repo
itself) assume that the dotfiles directory is placed under the `$HOME`
directory.

## Set up the configuration files

```
cd $HOME/dotfiles
```

### Tmux 

```
echo "source-file $HOME/dotfiles/.tmux.conf" >> ~/.tmux.conf
```

### Git

```
mkdir -p $HOME/dotfiles/.githooks
cp $HOME/dotfiles/bin/pre-commit $HOME/dotfiles/.githooks/pre-commit
git config --global include.path $(pwd)/.gitconfig
git config --local core.hooksPath .githooks/
```

### Vim/Nvim

```
echo "source $HOME/dotfiles/.vimrc" >> ~/.vimrc
mkdir -p $HOME/.config
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
```

### i3wm

```
mkdir -p $HOME/.config/i3
echo "include $HOME/dotfiles/i3config" >> $HOME/.config/i3/config
```

### IdeaVim

```
echo "source $HOME/dotfiles/.ideavimrc" >> ~/.ideavimrc
```

### Bash aliases

```
echo "source $HOME/dotfiles/.bash_aliases" >> ~/.bash_aliases
```

### Zsh

```
echo "source $HOME/dotfiles/.zshrc" >> ~/.zshrc
echo "source $HOME/dotfiles/.zsh_aliases" >> ~/.zsh_aliases
```

### Yazi

```
mkdir -p $HOME/.config/yazi
ln -s $HOME/dotfiles/yazi.toml $HOME/.config/yazi/yazi.toml
``
