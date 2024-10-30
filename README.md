# Setting up the configuration files

## Tmux 

```
echo "source-file $(pwd)/.tmux.conf" >> ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

## Git

```
git config --global include.path /home/fmajor/Git/Repos/dotfiles/.gitconfig
```

## Vim

```
echo "source $(pwd)/.vimrc" >> ~/.vimrc
```

## IdeaVim

```
echo "source $(pwd)/.ideavimrc" >> ~/.ideavimrc
```

## Bash aliases

```
echo "source $(pwd)/.bash_aliases" >> ~/.bash_aliases
source $(pwd)/.bash_aliases
```
