#!/bin/zsh

## Firefox 検索

local -A opthash
zparseopts -D -M -A opthash -- \
		   m -mail=m \
		   c -calendar=c\
		   h -help=h

usage() {
	echo "\nFirefox 検索"
	echo "Usage: firefox <option> [argument1]"
	echo 
	echo "オプション:"
	echo "[argument1]      : 検索ワード（複数ワード可）"
	echo "  -m, --mail     : Google Mail を開く"
	echo "  -c, --calendar : Google Calendar を開く"
	echo "  -h, --help     : ヘルプ表示"
	echo
	exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
	# -hまたは--helpが指定された場合
	usage
	exit 1
elif [[ -n "${opthash[(i)-m]}" ]]; then
	open -a Firefox https://mail.google.com/mail/ca/u/0/\#inbox
elif [[ -n "${opthash[(i)-c]}" ]]; then
	open -a Firefox https://calendar.google.com/calendar/render\?tab=Tc\#main_7
else
    if [ $# != 0 ]; then
		for i in $*; do
			# $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
			str="$str${str:++}$i"
		done
		opt='search?num=100'
		opt="${opt}&q=${str}"

		open -a Firefox http://www.google.co.jp/$opt
	else
		open -a Firefox http://www.google.co.jp/
	fi
fi
