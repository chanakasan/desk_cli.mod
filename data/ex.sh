nx_mux_cd2() {
  local name="$1"
  local base=$HOME/$2
  if [ -z $base ]; then
    echo " Usage:  nx_mux_cd <session_name> <dir_path>"
    exit 1
  fi
  local is_tmux=$(tmux-nested)
  local current=$(tmux-current-session)
  if [ "$current" == "$name" ]; then
    cd "$base"
  else
    mux $name
  fi
}