# Setting up the configuration files

```
cd DOTFILES_DIR
```

## Tmux 

1. First time setup

```
echo "source-file $(pwd)/.tmux.conf" >> ~/.tmux.conf
```

2. Reloading

```
tmux source-file ~/.tmux.conf
```

## Git (setup only once)

```
git config --global include.path $(pwd)/.gitconfig
```

## Vim (setup only once)

```
echo "source $(pwd)/.vimrc" >> ~/.vimrc
```

## IdeaVim (setup only once)

```
echo "source $(pwd)/.ideavimrc" >> ~/.ideavimrc
```

## Bash aliases

1. First time setup

```
echo "source $(pwd)/.bash_aliases" >> ~/.bash_aliases
```

2. Reloading

```
source ~/.bashrc
```

