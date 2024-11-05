alias less="less -RM"
rgl() {
  rg -p --stats "$@" | less -XF
}

setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Control_L=Escape'
