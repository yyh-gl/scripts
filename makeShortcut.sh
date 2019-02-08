# coding: utf-8

## 実行ディレクトリへのショートカットをzshrcに追加するプログラム

# 現在ディレクトリの相対パスを取得しzshrcに追記
if [ $# -eq 1 ]; then
	echo "alias $1='cd ~${PWD##*/Users/yyh-gl}/'" >> ~/.zprezto/runcoms/zshrc &&
	echo "\nMaking Shortcut is Done" &&
	echo "  >> $PWD" &&
	exit 0
else
	echo "[ERROR] Argument Error"
	echo "mksh arg1"
	echo "arg1 : shortcut name"
	exit 1
fi

# シェルの更新
exec $SHELL -l
