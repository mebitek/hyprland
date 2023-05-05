func_journalctl() {
  echo "func"
  if [ $# -eq 1 ]; then
    clear && journalctl -f -g $1 | ccze -A
  else
    clear && journalctl -f | ccze -A
  fi
}

alias jf="func_journalctl"
