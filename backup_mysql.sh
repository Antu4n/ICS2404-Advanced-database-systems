#!/bin/bash

# Variables
MYSQLDUMP_PATH="/c/Program Files/MySQL/MySQL Workbench 8.0/mysqldump.exe"
BACKUP_PATH="/c/Users/josep/OneDrive/Desktop/Antuan/School/Finalsssssss/4.1/Advanced DBS/ICS2404-Advanced-database-systems/Backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
DB_USER="root"
DB_PASS="gGolAtunji0!"
DB_NAME="portal"

# Backup command
"$MYSQLDUMP_PATH" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_PATH/backup_$TIMESTAMP.sql"

echo "Backup completed at $TIMESTAMP and saved to $BACKUP_PATH"

