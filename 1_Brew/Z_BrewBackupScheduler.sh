#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SCRIPT="$SCRIPT_DIR/Z_BrewBackup.sh"
PLIST_PATH="$HOME/Library/LaunchAgents/com.r18duarte.backupbrew.plist"
BUNDLE_DIR="$SCRIPT_DIR/Bundle"

# Ensure backup script exists and is executable
if [ ! -f "$BACKUP_SCRIPT" ]; then
    echo "Backup script not found at $BACKUP_SCRIPT"
    exit 1
fi
chmod +x "$BACKUP_SCRIPT"

# Create LaunchAgent plist if it doesn't exist
if [ ! -f "$PLIST_PATH" ]; then
    echo "Creating LaunchAgent plist at $PLIST_PATH..."
    cat > "$PLIST_PATH" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.r18duarte.backupbrew</string>
    <key>EnvironmentVariables</key>
<dict>
    <key>PATH</key>
    <string>/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
</dict>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$BACKUP_SCRIPT</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Weekday</key>
        <integer>1</integer> <!-- Sunday -->
        <key>Hour</key>
        <integer>2</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>

    <key>StartInterval</key>
    <integer>43200</integer> <!-- 12 hours fallback -->

    <key>RunAtLoad</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/tmp/backupbrew.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/backupbrew.err</string>
</dict>
</plist>
EOF

    launchctl load "$PLIST_PATH"
    echo "LaunchAgent loaded."
else
    echo "LaunchAgent already exists at $PLIST_PATH"
fi

# Optional restore
read -rp "Do you want to restore the latest Brewfile backup? (y/N): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    if [ -d "$BUNDLE_DIR" ]; then
        latest_file=$(ls -1t "$BUNDLE_DIR"/Brewfile_* 2>/dev/null | head -n 1)
        if [ -n "$latest_file" ]; then
            echo "Restoring from $latest_file..."
            brew bundle --file="$latest_file"
        else
            echo "No Brewfile backups found in $BUNDLE_DIR"
        fi
    else
        echo "Backup directory does not exist: $BUNDLE_DIR"
    fi
else
    echo "Restore skipped."
fi


read -rp "Do you want to remove the Brew backup LaunchAgent? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    if [ -f "$PLIST_PATH" ]; then
        echo "Unloading and deleting LaunchAgent..."
        launchctl unload "$PLIST_PATH" 2>/dev/null
        rm -f "$PLIST_PATH"
        echo "LaunchAgent removed."
    else
        echo "No LaunchAgent plist found at $PLIST_PATH"
    fi
else
    echo "Uninstall cancelled."
fi
