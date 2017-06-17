#!/bin/zsh

local -A opthash
zparseopts -D -M -A opthash -- \
	s \
	g \
	w \
    h -help=h

usage() {
  echo "Usage: $PROGNAME <option> [argument1]"
  echo 
  echo "オプション:"
  echo "[argument1]       : argument1の内容でコミット"
  echo "  -s  [argument1] : argument1の内容でコミット後プッシュ（Bitbucket）"
  echo "  -g  [argument1] : argument1の内容でコミット後プッシュ（Github）"
  echo "  -w  [argument1] : argument1の内容でコミット後プッシュ（Bitbucket & Github）"  
  echo "  -h, --help      : ヘルプ表示"
  echo
  exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
    # -hまたは--helpが指定された場合
    usage
    exit 1
elif [[ -n "${opthash[(i)-s]}" ]]; then
    git add . && git commit -m "$*" && git push -u origin master
elif [[ -n "${opthash[(i)-g]}" ]]; then
    git add . && git commit -m "$*" && git push -u gh master
elif [[ -n "${opthash[(i)-w]}" ]]; then
    git add . && git commit -m "$*" && git push -u origin master && git push -u gh master
else
    git add . && git commit -m "$*"
fi
