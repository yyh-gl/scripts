#!/bin/zsh

## LINE，Slack，Messenger，Skypeの起動

local -A opthash
zparseopts -D -M -A opthash -- \
		   l -line=l \
		   s -slack=s\
		   h -help=h

usage() {
	echo "\nメッセージアプリの起動"
	echo "Usage: msg <option>"
	echo 
	echo "オプション:"
	echo "  オプション無しだとLINEとSlackを両方開く"
	echo "  -l, --line  : LINE を開く"
	echo "  -s, --slack : Slack を開く"
	echo "  -h, --help  : ヘルプ表示"
	echo
	exit 1
}

if [[ -n "${opthash[(i)-h]}" ]]; then
	# -hまたは--helpが指定された場合
	usage
	exit 1
elif [[ -n "${opthash[(i)-l]}" ]]; then
	open -a LINE
elif [[ -n "${opthash[(i)-s]}" ]]; then
	open -a Slack
else
	open -a LINE
	open -a Slack
	open -a FreeChat\ for\ Facebook\ Messenger
	open -a Skype
fi
