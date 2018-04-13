function tex(){
    FILESTRING=$1
    FILENAME=${FILESTRING%.*}

    ## dvipdfmx のオプションとして ”-p a4”を指定することで余白，ページ番号の問題は解決される
    ## a4以外で出力するときは外すらしい．
    VAR=`nkf -g ${FILENAME}.tex`
    if [ "${VAR}" = "Shift_JIS" ]; then
        platex -kanji=sjis ${FILENAME}.tex
        pbibtex -kanji=sjis ${FILENAME}
        platex -kanji=sjis ${FILENAME}.tex
        platex -kanji=sjis ${FILENAME}.tex
        dvipdfmx -p a4 ${FILENAME}.dvi
        # open ${FILENAME}.pdf
    elif [ "${VAR}" = "EUC-JP" ]; then
        platex -kanji=euc ${FILENAME}.tex
        pbibtex -kanji=euc ${FILENAME}
        platex -kanji=euc ${FILENAME}.tex
        platex -kanji=euc ${FILENAME}.tex
        dvipdfmx -p a4 ${FILENAME}.dvi
        # open ${FILENAME}.pdf
    elif [ "${VAR}" = "UTF-8" ]; then
        platex -kanji=utf8 ${FILENAME}.tex
        pbibtex -kanji=utf8 ${FILENAME}
        platex -kanji=utf8 ${FILENAME}.tex
        platex -kanji=utf8 ${FILENAME}.tex
        dvipdfmx -p a4 ${FILENAME}.dvi
        # open ${FILENAME}.pdf
    fi
    echo ${VAR}
    rm -rf *.aux *.log *.dvi *.bbl *.blg
}

## YaTeX用 コンパイル & プレビュー プログラム
if [ $# = 1 ]; then
    tex $1 &&
    echo "${1%.*}.pdf" "pdf_${1%.*}.pdf" | xargs -n 2 mv &&
    #open -a preview "pdf_${1%.*}.pdf"
    open -a 'Adobe Acrobat Reader DC' "pdf_${1%.*}.pdf"
fi
