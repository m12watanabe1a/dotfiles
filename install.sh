#!/usr/bin/env bash
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  command echo "backup old dotfiles..."
  local backup_dir="$HOME/.cache"
  local install_dir="$HOME/.config"
  if [ ! -d "$backup_dir/.dotbackup" ];then
    command echo "$backup_dir/.dotbackup not found. Auto Make it"
    command mkdir -p "$backup_dir/.dotbackup"
  fi

  local dotdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  if [[ "$HOME" != "$dotdir" ]];then
    local dirs=`find $dotdir/* -maxdepth 0 -type d`
    for d in $dirs;
    do
      [[ `basename $d` == ".git" ]] && continue
      [[ `basename $d` == ".github" ]] && continue
      local installed_d=$install_dir/`basename $d`
      if [[ -L $installed_d ]];then
        command cp -rL "$installed_d" "$backup_dir/dotbackup"
        command rm -rf "$installed_d"
      fi
      command ln -snf $d $install_dir
    done
  else
    command echo "same install src dest"
  fi
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir
git config --global include.path "~/.gitconfig_shared"
command echo -e "\e[1;36m Install completed! \e[m"
