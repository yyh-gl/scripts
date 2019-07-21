echo "===================================================" &&
    echo "[RSYNC] START" &&
    echo "===================================================" &&
    # /hobbyの内容をトランセンドにバックアップ（シンボリックリンクを除く）
    echo "\n===================================================" &&
    echo "[RSYNC] ~/Desktop/hobby/ -> /Volumes/TRANSCEND" &&
    echo "===================================================" &&
    sudo rsync -auv --delete \
         --exclude '01_CasualLife/01_書類' \
         --exclude '02_ISDL'\
         --exclude '.DS_Store' \
         ~/Desktop/hobby/ \
         /Volumes/TRANSCEND &&
    # /Documents（書類）の内容をトランセンドにバックアップ
    echo "\n===============================================================" &&
    echo "[RSYNC] ~/Documents/ -> /Volumes/TRANSCEND/01_CasualLife/01_書類" &&
    echo "=================================================================" &&
    sleep 3 &&
    sudo rsync -auv --exclude '.DS_Store' \
         ~/Documents/ \
         /Volumes/TRANSCEND/01_CasualLife/01_書類 &&
    # トランセンドのバックアップ内容をNasneにバックアップ
    echo "\n==============================================================" &&
    echo "[RSYNC] /Volumes/TRANSCEND/ -> /Volumes/share1/Backup/Transcend" &&
    echo "==============================================================" &&
    sleep 3 &&
    sudo rsync -auv --exclude '.DS_Store' \
         /Volumes/TRANSCEND/ \
         /Volumes/share1/Backup/Transcend &&
    # トランセンドのバックアップ内容をHDDにバックアップ
    echo "\n==============================================================" &&
    echo "[RSYNC] /Volumes/TRANSCEND/ -> /Volumes/HDD_U_01_Main/99_Backup/01_Transcend" &&
    echo "==============================================================" &&
    sleep 3 &&
    sudo rsync -auv --exclude '.DS_Store' \
         /Volumes/TRANSCEND/ \
         /Volumes/HDD_U_01_Main/99_Backup/01_Transcend &&
    echo "\n===================================================" &&
    echo "[RSYNC] DONE" &&
    echo "==================================================="
