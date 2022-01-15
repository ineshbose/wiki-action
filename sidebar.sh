#!/bin/bash

echo "Building sidebar.."
cd $WIKI_DIR

IGNORE="$WIKI_IGNORE $SIDEBAR_IGNORE"
IGNORE_FILE="../temp_wiki_excluded_$GITHUB_SHA.txt"

echo "_Footer.md" >> $IGNORE_FILE
echo "_Sidebar.md" >> $IGNORE_FILE
test -e .wikignore && IGNORE="$IGNORE $(cat .wikignore | tr '\r\n' ' ')"

if [ -n "$IGNORE" ]; then
  for file in $IGNORE; do
    echo "$file" >> $IGNORE_FILE
  done
fi

for f in *; do
    if grep -q -x "$f" "$IGNORE_FILE"; then
      echo "Exclude $f"
      continue
    fi
    if [ -f "$f" ]; then
      echo "* [$(echo $f | sed 's/\.[^.]*$//')]($(echo $f | sed 's/\.[^.]*$//'))" >> _Sidebar.md
    else
      name="${f#*/}"
      echo "* ${name^}" >> _Sidebar.md
      for file in $f/*; do
        if grep -q -x "$file" "$IGNORE_FILE"; then
          echo "Exclude $file"
          continue
        fi
        echo "  * [$(basename $file | sed 's/\.[^.]*$//')]($(basename $file | sed 's/\.[^.]*$//'))" >> _Sidebar.md
      done
    fi
done

rm $IGNORE_FILE
cd ..