#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/Bundle"
LAST_RUN_FILE="$SCRIPT_DIR/.last_backup_run"
TIMESTAMP=$(date +"%Y-%m-%d")
FILENAME="Brewfile_$TIMESTAMP"
NOW=$(date +%s)
THRESHOLD=$((60 * 60 * 24 * 6)) # 6 days
BREW_PATH=$(which brew)

echo $BACKUP_DIR
echo "brew path"
echo $BREW_PATH
echo "2"

mkdir -p "$BACKUP_DIR"

# Check if a recent backup was already done
if [ -f "$LAST_RUN_FILE" ]; then
  LAST_RUN=$(cat "$LAST_RUN_FILE")
  if (( NOW - LAST_RUN < THRESHOLD )); then
    echo "Backup skipped — last run was less than 6 days ago."
    exit 0
  fi
fi

# Perform backup
$BREW_PATH bundle dump --file="$BACKUP_DIR/$FILENAME" --force
if [ $? -eq 0 ]; then
  echo "$NOW" > "$LAST_RUN_FILE"
  echo "Backup created at $FILENAME"
else
  echo "Backup failed."
  exit 1
fi

# Cleanup old backups
find "$BACKUP_DIR" -name "Brewfile_*" -type f -mtime +28 -delete

