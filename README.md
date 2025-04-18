# Setup Mac RD - Apr 2025

This repository contains a macOS setup script that installs essential tools and configures macOS to fit your daily workflow. It's designed to be run on a fresh macOS installation or anytime you need to quickly set up your environment.

---

## 📚 Index

1. Tools Installed
2. Bootstrap (First-time Setup)
3. Full Download (Clone & Execute)
---

## 🔧 Tools Installed

The following tools and utilities will be installed by the setup script:

- **Homebrew** – The macOS package manager
    
- **Git** – Version control system
    
- **Vim** – Text editor
    
- **zsh** – Default shell (if not already set)
    
- **wget** – Download utility
    
- **Google Chrome** – Web browser
    
- **iTerm2** – Terminal replacement
    
- **Visual Studio Code** – Code editor
    
- **Android Platform Tools** – For managing Android devices (`adb`, `fastboot`)
    
- **Android File Transfer** – GUI app for file transfers from Android devices
    
- **Rectangle** – Window manager
    
- **and more...** – see the script for all installed tools
    

---

## 🛠 Bootstrap (First-time Setup)

If you're setting up a **fresh macOS install** and **don’t have Homebrew or Git** installed, follow these steps to get everything up and running:

**Run the following command** in your terminal to install Homebrew, Git, and clone the repo:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles && \
cd ~/dotfiles && chmod +x setup.sh && ./setup.sh

```


### What this command does:

1. **Installs Homebrew** — macOS package manager
    
2. **Installs Git** — version control system (if it’s not already installed)
    
3. **Clones this repo** — `dotfiles` into `~/.dotfiles`
    
4. **Runs `setup.sh`** — Installs all the tools listed in the "Tools Installed" section


## 💻 Full Download (Clone & Execute)

If you already have **Homebrew** and **Git** installed on your Mac, or after you’ve run the bootstrap command, you can directly clone this repo and execute the setup:

1. **Clone the repo:**
```
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh && ./setup.sh
```

