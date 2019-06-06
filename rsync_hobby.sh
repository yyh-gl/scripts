echo "===================================================" &&
    echo "[RSYNC] START" &&
    echo "===================================================" &&
    echo "\n===================================================" &&
    echo "[RSYNC] ~/Desktop/hobby/ -> /Volumes/TRANSCEND" &&
    echo "===================================================" &&
    sudo rsync -auv --delete --exclude '02_ISDL' --exclude '.DS_Store' \
         ~/Desktop/hobby/ \
         /Volumes/TRANSCEND
    echo "\n===================================================" &&
    echo "[RSYNC] /Volumes/TRANSCEND/ -> /Volumes/share1/Backup/Transcend" &&
    echo "===================================================" &&
    sleep 3 &&
    sudo rsync -auv --exclude '.DS_Store' \
         /Volumes/TRANSCEND/ \
         /Volumes/share1/Backup/Transcend
    echo "\n===================================================" &&
    echo "[RSYNC] DONE" &&
    echo "==================================================="

