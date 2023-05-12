func_neosurf() {

  if [[ $# -eq 0 ]]; then
    neosurf-vi
    exit 0
  fi

  curl $1 > /dev/null
  if [[ $? -eq 0 ]]; then
    neosurf-vi $1
  else
    regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'
    if [[ $1 =~ $regex ]]
    then 
      neosurf-vi $1
    else
      neosurf-vi file://$1
    fi 
  fi
}


alias neosurf-vi='func_neosurf'
