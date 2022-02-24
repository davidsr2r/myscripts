#!/usr/bin/env bash
# Add BOM if no BOM found (BOM=Byte Order Marker)
# Delete -i and change command to make it pipeable
# Maybe it's the $* that's different in zsh vs. bash
# See: http://zsh.sourceforge.net/FAQ/zshfaq02.html

# Old script
# sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' $*


# Rodo's new script
if [ $# -eq 0 ]; then
  ## If no arguments, compare to origin/develop.
  FILES=$(git diff origin/develop --name-only)
  if [ -n "$FILES" ]; then
    echo $FILES | xargs ~/bin-r2r/fix-bom.sh
  fi
else
  # Add BOM if no BOM found (BOM=Byte Order Marker)
  sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' $*
fi
