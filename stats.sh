#!/bin/sh

set -eu

function main {
  git rev-list --reverse origin/master..master |
  while read rev; do
    echo "$(flog_complexity) $(number_of_lines) $(commit_description)"
  done
  git checkout master
}

function commit_description {
  git log -1 --oneline $rev
}

function number_of_lines {
  git ls-tree -r $rev |
  egrep "(item|gilded_rose).rb" |
  awk '{ print $3 }' |
  xargs git show |
  wc -l
}

function flog_complexity {
  git checkout --quiet $rev && flog -s item.rb gilded_rose.rb |
  awk '{print $1}' | tr -d ':' | xargs
}

main
