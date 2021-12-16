#!/usr/bin/env bash

this_file=$BASH_SOURCE


if [ -d ~/.config/bashrc.d ]; then
  for rc in ~/.config/bashrc.d/*.bash; do
    [[ $rc == $this_file ]] && continue
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

unset rc
unset modules
unset this_file
