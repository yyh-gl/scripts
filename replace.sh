#!/bin/sh

files="$1*"
for filepath in $files; do
  LC_ALL=C sed -i -e 's/printf/getch/g' $filepath
  rm -r -f "${filepath}-e"
done
