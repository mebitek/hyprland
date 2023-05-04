alias wca="warp-cli account"
alias wcd="warp_delete"
alias wcr="warp_register"

show_timeout() {
  i=20; 
  while [ $i -ge 0 ]; do 
    printf "\rConfirm cloudflare access in your browser ($i)"; 
    sleep 1 
    i=$((i-1))
  done; 
  echo "\n"  
}

check_account() {
  warp-cli account|grep -i "missing"
  if [ $? -eq 0 ]; then
    return 1
  fi  
}

warp_delete() {
  if check_account; then
    warp-cli delete    
  fi
}

warp_register() {
  readonly team=${1:?"The cloudflare team must be specified."}

  warp_delete
  warp-cli teams-enroll $team
  show_timeout
  if check_account; then
    warp-cli enable-always-on
    ps uax|grep -i warp-taskbar > /dev/null
    if [ $? -ne 0 ]; then
      killall warp-taskbar
      warp-taskbar &
    fi
  fi
}
