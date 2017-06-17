# coding: utf-8

## 実行ディレクトリへのショートカットをzshrcに追加するプログラム

# 現在ディレクトリの絶対パスを取得しzshrcに追記
echo "alias $1='cd $PWD/'" >> ~/.zprezto/runcoms/zshrc &&
echo "\nMake Shortcut Done" &&
echo "  >> $PWD" &&

# シェルの更新
exec $SHELL
