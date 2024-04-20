main() {
  local db_name=desk
  local verb="$1"
  local fn_name=$verb'_value'
  if [ "$verb" == "create" ]; then
    create_db
    exit 0
  fi
  validate
  start $@
}

validate() {
  check_db_dir
}

start() {
  if [ "$verb" == "get" ]; then
    get_value ${@:2}
  elif [ "$verb" == "set" ]; then
    set_value ${@:2}
  else
    echo "usage: db get|set key value"
  fi
}

set_value() {
  local key="$1"
  local value="$2"
  _write_file $@
}

get_value() {
  local key=$1
  if has_key $key; then
    echo $(_read_file $key)
  else
    echo "Key error"
    exit 1
  fi
}

has_key() {
  local key=$(get_db_dir)/$1
  if [ -f "$key" ]; then
    return 0
  else
    return 1
  fi
}

_read_file() {
  local file=$(get_db_dir)/$1
  if [ ! -f "$file" ]; then
    echo "Error: file not found $file"
    return 1
  fi
  local content=$(<"$file")
  local result=$(_trim_whitespace $content)
  echo $result
}

_trim_whitespace() {
  local result=$(echo -n "$1" | sed 's/[[:space:]]*$//')
  echo $result
}

_write_file() {
  local file=$(get_db_dir)/$1
  local value="$2"
  echo $value > "$file" || {
      echo "Error: Unable to write to file $file"
      return 1
  }
  return 0
}

get_db_dir() {
  local db_dir=$HOME/.local/$db_name.db
  echo $db_dir
}

create_db() {
  local db_dir=$(get_db_dir)
  mkdir -p $db_dir || {
    echo "Error cant create dir: $db_dir"
  }
}

check_db_dir() {
  local db_dir=$(get_db_dir)
  if [ ! -d "$db_dir" ]; then
    echo "db dir not found: $db_dir"
    echo "please create it first"
    exit 1
  fi
}

main $@
