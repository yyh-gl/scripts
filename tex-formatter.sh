#!/bin/zsh

## 「、。」を「，．」に変換するスクリプト

# paper.texを変換
echo "Translate -> ./paper.tex"
sed -i".backup" -e "s/、/，/g" -e "s/。/．/g" ./paper.tex

# chapter内のtexファイルを変換
for file in `\find ./chapter -name '*.tex'`; do
    echo "Translate -> $file"
    sed -i".backup" -e "s/、/，/g" -e "s/。/．/g" $file
done

# バックアップ用ファイルをバックアップディレクトリに移動
mv -f ./paper.tex.backup ./SedBackup/
mv -f ./chapter/*.backup ./SedBackup/
