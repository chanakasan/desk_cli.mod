export nex_desk_cli_base=$(nex _mod)/desk_cli.mod

desk() {
  source $nex_desk_cli_base/src/main/nx_desk.sh
  nx_desk $@
}
