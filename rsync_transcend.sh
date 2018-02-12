export LANG=ja_JP.UTF-8

###############
#  環境変数
###############
nowTime=`date +%Y%m%d_%H%M%S`
limit=5
sourcePath="/Volumes/TRANSCEND"
backupBasePath="/Volumes/amour/chizai/2017/M1/yhonda/16_TRANSCEND_BACKUP"
# sourcePath="/Users/Y_h/Desktop/test/root"
# backupBasePath="/Users/Y_h/Desktop/test/backup"
destPath=${backupBasePath}/${nowTime}
workPath=${backupBasePath}/work

execListBackupBasePath="ls \"\${backupBasePath}\" | grep \"[0-9]\{8\}_[0-9]\{6\}\""
pidFile=/var/run/backup.pid
mail="hoge@hoge.com"
subject="[Backup Log] ${nowTime}"

# LINE_SEP='
# '
LINE_SEP=$'\n'
IFS_DEFAULT=$IFS

##############
#   関数群
##############
# sendMail(){
# subjectBase64=""
# lines=`echo -e ${subject} | fold -c10`
# sep=""
# IFS=${LINE_SEP}
# for line in ${lines}; do
# subjectBase64=${subjectBase64}${sep}"=?UTF-8?B?`echo -e ${line} | base64`?="
# sep="\n\t"
# done
# IFS=${IFS_DEFAULT} 
# #subject="${subjectBase64%\\n\\t}"
# # echo -e ${subjectBase64}
# body=`echo -e $1 | base64`
# echo -e "To:${mail}\nSubject:${subjectBase64}\nContent-Type: text/plain; charset=UTF-8\nContent-Transfer-Encoding: base64\n\n$body" | /usr/sbin/sendmail -t
# }

checkError(){
	if [ $1 -ne 0 ]; then
		echo $2
		# sendMail "バックアップ異常終了\n$2"
		exit $1
	fi
}

checkProcess(){
	if [ -f "${pidFile}" ]; then
		PID=`cat "${pidFile}" `
		if (ps -e | awk '{print $1}' | grep ${PID} > /dev/null); then
			return 1
		fi
	fi
	echo $$ > "${pidFile}"
	return 0
}

judgeFullBackup() {
	local result=0
	fullBackup=1
	local countBackup=`eval ${execListBackupBasePath} | wc -l`
	if [ ${countBackup} -ne 0 ]; then
		fullBackup=0
		beforeBackup=`eval ${execListBackupBasePath} | sort -r | head -n 1`
		result=$?
		beforeBackup="${backupBasePath}/${beforeBackup}"
	fi
	return ${result}
}

runBackup() {
	if [ -d "${workPath}" ]; then
		echo 作業用ディレクトリを削除します。
		echo rm "${workPath}"
		rm -rf "${workPath}"
		result=$?
		checkError ${result} "作業用ディレクトリ削除に失敗しました。"
	fi
	
	if [ $fullBackup -eq 1 ]; then
		echo バックアップ種類 ベースバックアップ
		echo バックアップソース "${sourcePath}"
		echo バックアップ先 "${destPath}"
	else
		echo バックアップ種類 差分バックアップ
		echo バックアップソース "${sourcePath}"
		echo バックアップ比較元 "${beforeBackup}"
		echo バックアップ先 "${destPath}"
	fi
	echo ${LINE_SEP}
	
	if [ $fullBackup -eq 1 ]; then
		#(time rsync -av --chmod=ugo-w --delete "${sourcePath}/" "${workPath}/")
		#(time rsync -av --delete "${sourcePath}/" "${workPath}/")
		(time rsync -av "${sourcePath}/" "${workPath}/")
	else
		#(time rsync -av --chmod=ugo-w --delete --link-dest="${beforeBackup}" "${sourcePath}/" "${workPath}/")
		#(time rsync -av --delete --link-dest="${beforeBackup}" "${sourcePath}/" "${workPath}/")
		(time rsync -av --link-dest="${beforeBackup}" "${sourcePath}/" "${workPath}/")
	fi
	result=$?
	checkError ${result} "バックアップに失敗しました。"
	
	mv "${workPath}" "${destPath}"
	result=$?
	checkError ${result} "作業ディレクトリの名前変更に失敗しました。"
	
	return 0
}

deleteBackup() {
	IFS=$LINE_SEP
	local countBackup=`eval ${execListBackupBasePath} | wc -l`
	local countDelete=`expr ${countBackup} - ${limit}`
	if [ $countDelete -gt 0 ]; then
		local deleteDirs=`eval ${execListBackupBasePath} | sort | head -n ${countDelete}`
		for deleteDir in ${deleteDirs}; do
			deleteDir="${backupBasePath}/${deleteDir}"
			echo delete "${deleteDir}"
			(time rm -rf "${deleteDir}")
		done
	fi
	IFS=${IFS_DEFAULT} 
}

####################
#   メイン処理
####################
echo "#########################"
echo backup start
date "+%Y-%m-%d %H:%M:%S"
echo "#########################"

checkProcess
result=$?
checkError ${result} "多重起動エラー"

# パスの存在チェック
if [ ! -d "${sourcePath}" ]; then
	checkError 1 "${sourcePath}がありません。"
fi

if [ ! -d "${backupBasePath}" ]; then
	checkError 1 "${backupBasePath}がありません。"
fi

if [ -d "${destPath}" ]; then
	checkError 1 "${destPath}が既に存在しています。"
fi

# バックアップモード決定
judgeFullBackup
result=$?
checkError ${result} "バックアップモード決定に失敗しました。"

# バックアップ実行
runBackup
result=$?
checkError ${result} "バックアップに失敗しました。"

# 古いバックアップファイルを削除
deleteBackup

echo "#########################"
echo backup end
date "+%Y-%m-%d %H:%M:%S"
echo "#########################"
rm "${pidFile}"

# sendMail "バックアップ正常終了"
echo "バックアップ正常終了"
