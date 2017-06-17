#!/bin/zsh

## SafariでYouTube

local -A opthash
zparseopts -D -M -A opthash -- \
		   hi -history=hi \
		   h -help=h

usage() {
	echo "\nYouTube 検索"
	echo "Usage: youtube <option> [argument1]"
	echo 
	echo "オプション:"
	echo "[argument1]      : argument1のワードで検索（複数ワード可）"
	echo "  -hi, --history : YouTubeの履歴を開く"
	echo "  -h, --help     : ヘルプ表示"
	echo
	exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then

fi

local str opt
if [[ -n "${opthash[(i)-h]}" ]]; then
	# -hまたは--helpが指定された場合
	usage
	exit 1
elif [[ -n "${opthash[(i)-hi]}" ]]; then
    open -a Safari https://www.youtube.com/feed/history
else
    if [ $# != 0 ]; then	
		for i in $*; do
			# $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
			str="$str${str:++}$i"
		done
		opt="${opt}${str}"

		open -a Safari https://www.youtube.com/results\?search_query=$opt
	else
		open -a Safari https://www.youtube.com/
	fi
fi
