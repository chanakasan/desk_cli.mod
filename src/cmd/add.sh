main() {
  local path1=""
  local name=""
  if [ -z "$1" ]; then
    println "Usage: add_desk <path> <name>"
    return 1
  fi
  if [ "$1" == "." ]; then
    path1=$(pwd)
  else
    path1=$(readlink -f "$1")
  fi
  if [ -z "$2" ]; then
    name=$(basename "$path1")
  fi
  
  local desk_dir="$HOME/.desk"
  local file_path="$desk_dir/$name"
  
  if [ ! -d "$desk_dir" ]; then
      mkdir -p "$desk_dir" || {
          println "Error: Unable to create directory $desk_dir"
          return 1
      }
  fi
  
  echo $path1 > "$file_path" || {
      println "Error: Unable to write to file $file_path"
      return 1
  }
  
  echo " desk added: $name"
}

println() {
  echo " $1"
}

main $@
