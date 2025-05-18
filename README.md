# Setup Mac RD - Apr 2025

This repository contains a macOS setup script that installs essential tools and configures macOS. It's designed to be run on a fresh macOS installation or anytime you need to update and make sure we still have the original setup running.

---

## 📚 Index

1. Tools Installed
2. Bootstrap (First-time Setup)
3. Full Download (Clone & Execute)

---

## Configs added

### Sys

- **TouchID for sudo**
- Enable sound when plugging in device
- Disable Time Machine pop-up when a device is connected
- Enable auto updates
- Enable Location Services
- Set auto timezones and set it with location
- Activity Monitor: Show data in graph
- Uncheck 'Reopen windows when logging back in'
- Enable firewall
- Disable PowerNap and Wake for Network Access
- Disable Password hint on login screen

### Finder

- New finder windows now point to ~/
- Show path
- Show status bar
- Show collumns by default
- Disable creating -DS_Store for network and removable devices
- Remove recent apps from dock

### Menu Bar

- Removed Siri
- Added battery percentage

## 🔧 Tools Installed

The following tools and utilities will be installed by the setup script:

- **Homebrew** – The macOS package manager

- **Git** – Version control system

- **GH** - Github Authentication tool

- **Vim** – Text editor

- **oh-my-zsh** – Default shell but better

- **Google Chrome** – Web browser

- **iTerm2** – Terminal replacement

- **Android Platform Tools** – For managing Android devices (`adb`, `fastboot`)

- **Android File Transfer** – GUI app for file transfers from Android devices

- **Rectangle** – Window manager

- **and more...** – see the script for all installed tools

---

## 🛠 Download git clone and exec

If you're setting up a **fresh macOS install** and **don’t have Homebrew or Git** installed, follow these steps to get everything up and running:

**Run the following command** in your terminal to install Homebrew, Git, clone the repo and execute setup script:

**Default folder is ~/dotfiles/**

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
mkdir -p ~/dotfiles
git clone https://github.com/r18duarte/mac-dotfiles.git ~/dotfiles
chmod +x ~/dotfiles/macsetup.sh
sudo /dotfiles/macsetup.sh
```

### What this command does

1. **Installs Homebrew** — macOS package manager

2. **Installs Git** — version control system (if it’s not already installed)

3. **Clones this repo** — `dotfiles` into `~/dotfiles`

4. **Runs `macsetup.sh`** — Installs all the tools listed in the "Tools Installed" section

## Apps

- TG Pro
- Dropover
- Raycast
- HidenBar (appstore)
- keka (uncompresser)
- neardrop (github)
- cleanmymac