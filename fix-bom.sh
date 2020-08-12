#!/usr/bin/env bash
# Add BOM if no BOM found (BOM=Byte Order Marker)
# Delete -i and change command to make it pipeable
# Maybe it's the $* that's different in zsh vs. bash
# See: http://zsh.sourceforge.net/FAQ/zshfaq02.html
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' $*
