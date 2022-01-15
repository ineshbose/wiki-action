#!/bin/bash

if [ -z "$GH_TOKEN" ]; then
    echo "Token is not specified"
    exit 1
fi

echo "Cloning wiki repository.."
git clone "https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git" "wiki_temp_$GITHUB_SHA"

echo "Copying from $WIKI_DIR.."
cp -R "wiki_temp_$GITHUB_SHA/.git" "$WIKI_DIR/"

echo "Checking for changes.."
cd "$WIKI_DIR"
git config --local user.email "$(git log -1 --format='%ae')"
git config --local user.name "$(git log -1 --format='%an')"

test -e .wikignore && cat .wikignore >> .gitignore
if [ -n "$WIKI_IGNORE" ]; then
  for file in $WIKI_IGNORE; do
    echo "$file" >> .gitignore
  done
fi

git add .

if git diff-index --quiet HEAD; then
    echo "Nothing changed"
    exit 0
fi

echo "Pushing to wiki.."
git commit -m "$(git log -1 --format='%s')" && git push -u "https://$GITHUB_ACTOR:$GH_TOKEN@github.com/$GITHUB_REPOSITORY.wiki.git" master -f