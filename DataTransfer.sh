## Linux上で実験を行い，取得したログデータをMacに転送するプログラム
## → Linux上のログデータが入ってるディレクトリで実行

if [ $# -ne 1 ]; then
    echo "作成するディレクトリ名を入力してください．"
fi

# target_dir_1="/home/yyh/Desktop/`date '+%Y%m%d'`/"
# target_dir_2="/home/yyh/Desktop/`date '+%Y%m%d'`/$1/"
target_dir_1="/home/yyh/Desktop/Parallels Shared Folders/Home/Desktop/`date '+%Y%m%d'`/"
target_dir_2="/home/yyh/Desktop/Parallels Shared Folders/Home/Desktop/`date '+%Y%m%d'`/$1/"
if [ ! -e "$target_dir_1" ]; then
    mkdir "$target_dir_1"
fi
if [ ! -e "$target_dir_2" ]; then
    mkdir "$target_dir_2"
fi
mv *.csv "$target_dir_2"
mv *.txt "$target_dir_2"
