#!/bin/zsh
# Compile Java file
gcc $1
if [ $? -eq 0 ]; then
	./a.out $2
else
	echo "\nCompile failed"
fi
rm -rf a.out
