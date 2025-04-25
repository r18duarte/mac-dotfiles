#!/bin/bash

###
#
#                Author : Ricardo Duarte
#         Last Modified : 2025-04-18
#               Version : 1.0
#           Tested with : macOS 15.2
#
###

# Get current Username and User ID
CURRENT_USER=$(stat -f %Su /dev/console)
USER_ID=$(id -u "$CURRENT_USER")

# Check sudo status
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root, press enter to authorize."
  read
  exec sudo bash "$0" "$@"
else
  echo "Running as root."
fi

###########
# MENU BAR #
############

# Show battery percentage
sudo -u "$CURRENT_USER" defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Disable Siri
sudo -u "$CURRENT_USER" defaults write com.apple.Siri StatusMenuVisible -bool false
sudo -u "$CURRENT_USER" defaults write com.apple.assistant.support "Assistant Enabled" -bool false

##########
# FINDER #
##########

# Show all filename extensions
sudo -u "$CURRENT_USER" defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
sudo -u "$CURRENT_USER" defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
sudo -u "$CURRENT_USER" defaults write com.apple.finder ShowStatusBar -bool true

# New Finder windows points to home
sudo -u "$CURRENT_USER" defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Disable the warning when changing a file extension
sudo -u "$CURRENT_USER" defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Always show scrollbars. Possible values: `WhenScrolling`, `Automatic` and `Always`
sudo -u "$CURRENT_USER" defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

# Always show hidden files
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

# Expand print panel by default
sudo -u "$CURRENT_USER" defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
sudo -u "$CURRENT_USER" defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Avoid creating .DS_Store files on network or USB volumes
sudo -u "$CURRENT_USER" defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
sudo -u "$CURRENT_USER" defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable recent apps in Dock
launchctl asuser "$USER_ID" sudo -u "$CURRENT_USER" defaults write com.apple.dock show-recents -int 0

# Show hard drives and network drives on the Desktop
sudo -u "$CURRENT_USER" defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
sudo -u "$CURRENT_USER" defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

###################
# SYSTEM SETTINGS #
###################
# Beep feedback when plugging in the power adapter
sudo -u "$CURRENT_USER" defaults write com.apple.PowerChime ChimeOnAllHardware -bool true

# Prevent Time Machine from prompting to use new hard drives as backup volume
sudo -u "$CURRENT_USER" defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Expand save panel by default
sudo -u "$CURRENT_USER" defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Prevent Photos.app from opening when a device is plugged
sudo -u "$CURRENT_USER" defaults write com.apple.ImageCapture disableHotPlug -bool yes

# Disable shadows on screenshots
sudo -u "$CURRENT_USER" defaults write com.apple.screencapture disable-shadow -bool true

# Enable automatic updates
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

# Startup Chime / StartupMute=%01 to mute
nvram StartupMute=%00

# Enable location services
defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
killall locationd
launchctl kickstart -k system/com.apple.locationd

# Configure automatic timezone
defaults write /Library/Preferences/com.apple.timezone.auto Active -bool YES
defaults write /private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeOnlyEnabled -bool YES
defaults write /private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeZoneEnabled -bool YES

# Set time, date, timezone automatically using current location
/usr/sbin/systemsetup -setusingnetworktime on
/usr/sbin/systemsetup -gettimezone
/usr/sbin/systemsetup -getnetworktimeserver

# Activity Monitor : Show Data in graph instead of IO and packets
sudo -u "$CURRENT_USER" defaults write com.apple.ActivityMonitor DiskGraphType -int 1
sudo -u "$CURRENT_USER" defaults write com.apple.ActivityMonitor NetworkGraphType -int 1

# Uncheck 'Reopen Windows When Logging Back'
sudo -u "$CURRENT_USER" defaults write com.apple.loginwindow TALLogoutSavesState -bool false

# Enable Firewall
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
/usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Disable Power Nap & Wake for Network Access
pmset -a powernap 0
pmset -a womp 0

# Stop macOS 15 Sequoia monthly screen recording prompts for Chrome, Slack, Zoom, Teams and TeamViewer
defaults write "/Users/$CURRENT_USER/Library/Group Containers/group.com.apple.replayd/ScreenCaptureApprovals.plist" "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" -date "3024-09-22 12:12:12 +0000"
defaults write "/Users/$CURRENT_USER/Library/Group Containers/group.com.apple.replayd/ScreenCaptureApprovals.plist" "/Applications/Slack.app/Contents/MacOS/Slack" -date "3024-09-22 12:12:12 +0000"
defaults write "/Users/$CURRENT_USER/Library/Group Containers/group.com.apple.replayd/ScreenCaptureApprovals.plist" "/Applications/zoom.us.app/Contents/MacOS/zoom.us" -date "3024-09-22 12:12:12 +0000"
defaults write "/Users/$CURRENT_USER/Library/Group Containers/group.com.apple.replayd/ScreenCaptureApprovals.plist" "/Applications/Microsoft Teams.app/Contents/MacOS/MSTeams" -date "3024-09-22 12:12:12 +0000"
defaults write "/Users/$CURRENT_USER/Library/Group Containers/group.com.apple.replayd/ScreenCaptureApprovals.plist" "/Applications/TeamViewer.app/Contents/MacOS/TeamViewer" -date "3024-09-22 12:12:12 +0000"

################
# LOGIN SCREEN #
################

# Disable password hints
defaults write com.apple.loginwindow RetriesUntilHint -int 0

########
# SUDO #
########

# TouchID for sudo
CHECK_3RD_ROW=$(cat /private/etc/pam.d/sudo_local | sed -n 3p)

# Checking if Sudo Touch ID is already configured
if [ "$CHECK_3RD_ROW" = "auth       sufficient     pam_tid.so" ]; then
  osascript -e 'tell application (path to frontmost application as text) to display dialog "Sudo Touch ID is already configured." buttons {"OK"} with icon note'
else
  # Create sudo_local from template
  cp /private/etc/pam.d/sudo_local.template /private/etc/pam.d/sudo_local

  # Backup sudo_local then remove '#' at line 3
  sed -i '.bak' '3s/#//' "/private/etc/pam.d/sudo_local"

  # Dialog
  osascript -e 'tell application (path to frontmost application as text) to display dialog "Sudo Touch ID is now available.\nPlease quit and re-run your Terminal." buttons {"OK"} with icon note'
fi

#################
# Brew and Apps #
#################

# Brew was previously installed as the setup requires it

# Update brew
brew upgrade

# Brew install apps from file
xargs brew install <brew_apps.txt

##################
# Setup terminal #
##################

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerline10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

# Symlink .zshrc to home folder
ln -s ~/dotfiles/.zshrc ~/.zshrc

#################
# Neovim config #
#################

# backup default config
mv ~/.config/nvim{,.bak}

# symlink to nvim config folder
ln -s ~/dotfiles/nvim ~/.config/nvim

####################
# RESTART SERVICES #
####################

killall cfprefsd
killall SystemUIServer
killall -HUP bluetoothd
killall ControlStrip
killall Finder
killall Dock
killall TextInputMenuAgent
killall WindowManager
killall replayd

exit 0
