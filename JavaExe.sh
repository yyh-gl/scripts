#!/bin/zsh
# Compile Java file
javac $1 &&
num=${#1}
if [ $? -eq 0 ]; then
	java ${1:0:$num-5}
else
	echo "\nCompile failed"
fi
rm -rf *.class
