#!/bin/zsh

trap "rm -rf *.aux *.log *.dvi *.bbl *.blg" 0
test -n "$1" || echo "usage: platex2pdf [tex-file]"
test -n "$1" || exit 1 # 引数が無ければ syntax を表示して終了
TEX=$*
DVI=`/usr/bin/basename "$TEX" ".tex"`
PDF="${DVI}.pdf"
THECODE=`nkf -g "$TEX"`
case "$THECODE" in # nkf が返す文字コードにあわせる
    "UTF-8") 
	KANJI="-kanji=utf8"
	OPTION="-w";;
    "EUC-JP") 
	KANJI="-kanji=euc"
	OPTION="-e";;
    "Shift_JIS") 
	KANJI="-kanji=sjis"
	OPTION="-s";;
    "ISO-2022-JP") 
	KANJI="-kanji=jis"
	OPTION="-j";;
esac
# 各種ファイルを変換
ls | grep "\.sty" >/dev/null 2>&1
if test $? -eq 0 ;then
    for STYFILE in *.sty
    do
	nkf $OPTION --overwrite $STYFILE
    done
fi
ls | grep "\.cls" >/dev/null 2>&1
if test $? -eq 0 ;then
    for STYFILE in *.cls
    do
	nkf $OPTION --overwrite $STYFILE
    done
fi
ls | grep "\.bib" >/dev/null 2>&1
if test $? -eq 0 ;then
    for BIBFILE in *.bib
    do
	nkf $OPTION --overwrite $BIBFILE
    done
fi
ls | grep "\.bst" >/dev/null 2>&1
if test $? -eq 0 ;then
    for BSTFILE in *.bst
    do
	nkf $OPTION --overwrite $BSTFILE
    done
fi

PLATEX="platex"
BIBTEX="pbibtex"
CLASS=`sed -n '/documentclass/p' $* | sed '/%.*documentclass/d' | sed -n '1p'`
case $CLASS in
    *{u*) PLATEX="uplatex";;
esac

ls | grep 'ieicej.cls' >/dev/null 2>&1
if test $? -eq 0 ;then
    DVIPDF_OPTION="-p 182mm,257mm -x 1in -y 1in"
else
    DVIPDF_OPTION=""
fi

$PLATEX $KANJI $TEX # platex コマンドの発行
$BIBTEX $DVI # >/dev/null 2>&1 # pbibtex コマンドの発行
$PLATEX $KANJI $TEX >/dev/null 2>&1 # platex コマンドの発行
$PLATEX $KANJI $TEX >/dev/null 2>&1 # platex コマンドの発行
dvipdfmx $DVIPDF_OPTION $DVI # dvipdfmx コマンドの発行
open $PDF & # PDFファイルを表示
rm *.aux *.log *.dvi *.bbl *.blg
