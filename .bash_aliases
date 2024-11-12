alias less="less -RM"
alias vim=nvim
rgl() {
  rg -p --stats "$@" | less -XF
}

setxkbmap -option 'caps:ctrl_modifier' && xcape -e '#66=Escape'
