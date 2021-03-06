#!/usr/bin/env bash

organization=""
target=$HOME/.ssh/authorized_keys

if [ -n "$organization"]
then

  echo "# $organization members" > $target
  for row in $(gh api /orgs/$organization/members | \
    jq -r '.[] | {type: .type, username: .login} | select( .type | contains("User")) | { username: .username } | @base64'
  ); do
    _jq() {
      echo ${row} | base64 --decode | jq -r ${1}
    }
    username=$(_jq '.username')
    echo "Add: $username"
    wget -qO- https://github.com/${username}.keys >> $target
  done
  unset username row
fi
unset organization target

