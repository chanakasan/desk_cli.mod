nx_desk() {
  local bin_path=$nex_desk_cli_base/src/cmd/$1.sh
  if [ -f "$bin_path" ]; then
    bash $bin_path ${@:2}
    return 0
  else
    echo " cmd not found: desk $@"
  fi
}

nx_desk_cd() {
  local bin_path=$nex_desk_cli_base/bin/desk_find
  local desk_path=$($bin_path $1)
  if [ -d "$desk_path" ]; then
    cd $desk_path
  elif [ -n "$1" ]; then
    echo " desk not found: $1"
  else
    echo " desk not found for pwd"
  fi
}
