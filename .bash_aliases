alias less="less -RM"
alias vim=nvim
rgl() {
  rg -p --stats "$@" | less -XF
}
