# coding: utf-8

# 現在ディレクトリの絶対パスを取得しDesktopにシンボリックリンクを作成
if [ $# -eq 0 ]; then
		ln -s $PWD/ ~/Desktop &&
		echo "\nMaking Symbolic Link is Done"
		exit 1
elif [ $# -eq 1 ]; then
		ln -s $PWD/ ~/Desktop/$1 &&
		echo "\nMaking Symbolic Link is Done"
		exit 1
else
		echo "[ERROR] Argument Error"
		echo "mkln [ arg1 ]"
		echo "arg1 : shortcut name"
		exit 1
fi
