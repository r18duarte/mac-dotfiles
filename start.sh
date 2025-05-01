# Get Current location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting Setup"
echo "Executing Sys Settings Script"
sudo bash $SCRIPT_DIR/0_Scripts/1_SysSettings.sh

echo "Finished"

echo "Running Brew App install"
bash $SCRIPT_DIR/1_Brew/1_Apps.sh

echo "Restoring Brew Bundle"
bash $SCRIPT_DIR/1_Brew/2_BundleRestore.sh


# Brew bundle backup
read -p "Do you want to implement the backup routine? (y/n): " answer

if [ "$answer" == "y" ]; then
if [ -f $SCRIPT_DIR/0_Scripts/brew_backup_*.txt ]; then
echo "Backup already done."
else
crontab -l | { cat; echo "0 2 * * 1 brew list > ~/brew_backup_$(date +\%Y-\%m-\%d).txt"; } | crontab -
echo "Backup routine implemented."
fi
else
echo "Backup routine not implemented."
fi
