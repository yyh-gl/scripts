#!/bin/zsh

## Yahoo 検索

local -A opthash
zparseopts -D -M -A opthash -- \
		   h -help=h

usage() {
	echo "\nYahoo 検索"
	echo "Usage: yahoo <option> [argument1]"
	echo 
	echo "オプション:"
	echo "[argument1]  : 検索ワード（複数ワード可）"
	echo "  -h, --help : ヘルプ表示"
	echo
	exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
	# -hまたは--helpが指定された場合
	usage
	exit 1
else
	if [ $# != 0 ]; then
		for i in $*; do
       		# $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
			str="$str${str:++}$i"
		done
		opt="${str}"

		open -a Google\ Chrome "https://search.yahoo.co.jp/search?p=$opt"
	else
		open -a Google\ Chrome "https://search.yahoo.co.jp/"
	fi
fi
