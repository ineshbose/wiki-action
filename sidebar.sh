#!/bin/bash

iterate_folder() {
  if grep -q -x "$1" "$IGNORE_FILE"; then
    return
  fi
  if [ -f "$1" ]; then
    line="$(printf '%0*s' $2 | tr '0' '\t')- [$(basename $1 | sed 's/\.[^.]*$//')]($(basename $1 | sed 's/\.[^.]*$//'))"
    echo "$line" >> _Sidebar.md
  else
    name="${1#*/}"
    line="$(printf '%0*s' $2 | tr '0' '\t')- ${name^}"
    echo "$line" >> _Sidebar.md
    for file in $1/*; do
      level=$2
      level=$((level+1))
      iterate_folder $file $level
    done
  fi
}

echo "Building sidebar.."
cd $WIKI_DIR

IGNORE="$WIKI_IGNORE $SIDEBAR_IGNORE"
IGNORE_FILE="../temp_wiki_excluded_$GITHUB_SHA.txt"

echo "_Footer.md" >> $IGNORE_FILE
echo "_Sidebar.md" >> $IGNORE_FILE

if [ -n "$IGNORE" ]; then
  for file in $IGNORE; do
    echo "$file" >> $IGNORE_FILE
  done
fi

for f in *; do
  iterate_folder $f 0
done

rm $IGNORE_FILE
cd ..