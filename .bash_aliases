alias less="less -RM"
rgl() {
  rg -p --stats "$@" | less -XF
}
