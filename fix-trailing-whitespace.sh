## Fixup all lines ending in /r, then fix lines not ending in /r
# Rodo's old solution
# sed -i 's/[ \W]*\r$/\r/' $*

# Rodo's new solution
if [ $# -eq 0 ]; then
  ## If no arguments, compare to origin/develop.
  FILES=$(git diff origin/develop --name-only)
  if [ -n "$FILES" ]; then
    echo $FILES | xargs ~/bin-r2r/fix-trailing-whitespace.sh
  fi
else
  ## Fixup all lines ending in /r, then fix lines not ending in /r
  sed -i 's/[ \W]*\r$/\r/' $*
fi
