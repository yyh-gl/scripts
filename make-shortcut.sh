# coding: utf-8

## 実行ディレクトリへのショートカットをzshrcに追加するプログラム

# 現在ディレクトリの相対パスを取得しzshrcに追記
if [ $# -eq 1 ]; then
    cp ~/.zprezto/runcoms/zshrc ~/.zprezto/runcoms/zshrc.copy
    rm -f ~/.zprezto/runcoms/zshrc
    sed '$d' ~/.zprezto/runcoms/zshrc.copy >> ~/.zprezto/runcoms/zshrc
    chmod +x ~/.zprezto/runcoms/zshrc
	echo "alias $1='cd ~${PWD##*/Users/yyh-gl}/'\n" >> ~/.zprezto/runcoms/zshrc
	echo "\nMaking Shortcut is Done"
	echo "  >> $PWD"
    rm -f ~/.zprezto/runcoms/zshrc.copy
	exit 0
else
	echo "[ERROR] Argument Error"
	echo "mksh arg1"
	echo "arg1 : shortcut name"
	exit 1
fi

# シェルの更新
exec $SHELL -l
