alias th=fitbit-vault-token-helper
alias db="$HOME/src/fitbit/ops/cosmos/fitbit/dbe/usr/bin/fitbit_dbaccess"
alias fcount="$HOME/fcount"
alias less="less -RM"
rgl() {
  rg -p --stats "$@" | less -XF
}
