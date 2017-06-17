#!/bin/zsh

# Gitのリポジトリ初期化とファーストコミット
function gitinit()
{
    git init &&    
	git remote add origin $1 &&
	git add . &&
	git commit -m "First Commit" &&
	git push -u origin master
    echo "Success Git Initialize"
}
