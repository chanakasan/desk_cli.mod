main() {
  local desk_name=$1
  local all_file="$HOME/.desk/_all"
  local list_cmd=$nex_desk_cli_base/src/cmd/list.sh
  if [ -n "$desk_name" ] && [[ -f "$HOME/.desk/$desk_name" ]]; then
    echo $(find_by_name $desk_name)
  else
    $list_cmd
    echo $(find_by_current_dir $PWD)
  fi
}

find_by_current_dir() {
  local result=""
  while IFS= read -r line; do
    if [[ -n $line ]] && [[ "$1" == *"$line"* ]]; then
      result=$line
      break
    fi
  done < "$all_file"
  echo $result
}

find_by_name() {
  local file=$HOME/.desk/$1
  local result=$(<"$file")
  result=$(echo -n "$value" | sed 's/[[:space:]]*$//')
  echo $result
}

main $@
