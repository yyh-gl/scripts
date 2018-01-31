#!/bin/zsh

## プロキシスイッチャー

user_name=''
password=''
proxy_address=''
proxy_port=''

local -A opthash
zparseopts -D -M -A opthash -- \
		   0 -off=0 \
		   1 -on=1\
		   h -help=h

usage() {
	echo "\n プロキシ設定のON/OFF"
	echo "Usage: proxy <option>"
	echo 
	echo "オプション:"
	echo "  -0, --off  : プロキシ OFF"
	echo "  -1, --on   : プロキシ ON"
	echo "  -h, --help : ヘルプ表示"
	echo
	exit 1
}

proxy="http://$user_name:$password@$proxy_address/"
if [[ -n "${opthash[(i)-h]}" ]]; then
	# -hまたは--helpが指定された場合
	usage
	exit 1
elif [[ -n "${opthash[(i)-0]}" ]]; then
	unset http_proxy
	unset ftp_proxy
	unset all_proxy
	unset https_proxy

	git config --global --unset http.proxy
	git config --global --unset https.proxy
	git config --global --unset url."https://".insteadOf
	exit 1
elif [[ -n "${opthash[(i)-1]}" ]]; then
	export http_proxy=$proxy
	export ftp_proxy=$proxy
	export all_proxy=$proxy
	export https_proxy=$proxy

	git config --global http.proxy $proxy
	git config --global https.proxy $proxy
	git config --global url."https://".insteadOf git://
	exit 1
else
	echo "オプションを指定してください"
	exit 0
fi
