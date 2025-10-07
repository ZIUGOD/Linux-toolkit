#!/bin/bash 
# Use Bash to interpret this script

set -e
# Exit the script immediately if any command fails (non-zero exit code)

echo "[+] Updating your system..."

sudo apt update -y
# Update the list of available packages

sudo apt full-upgrade -y
# Upgrade all installed packages (may add/remove packages to complete upgrades)

sudo apt autoremove -y
# Remove packages that were installed as dependencies but are no longer needed

sudo apt clean
# Delete cached .deb files in /var/cache/apt/archives to free up space

if ! command -v neofetch &>/dev/null; then
    # Check if the 'neofetch' command is NOT available (command not found)

    echo "[+] Installing 'neofetch'..."
    # Inform the user that neofetch will be installed

    sudo apt install -y neofetch
    # Install neofetch without prompting the user
fi

neofetch

# ┌─────────────────────────────────────────────────┐
# │                                                 │
# │ ▒███████▒ ██▓ █    ██   ▄████  ▒█████  ▓█████▄  │
# │ ▒ ▒ ▒ ▄▀░▓██▒ ██  ▓██▒ ██▒ ▀█▒▒██▒  ██▒▒██▀ ██▌ │
# │ ░ ▒ ▄▀▒░ ▒██▒▓██  ▒██░▒██░▄▄▄░▒██░  ██▒░██   █▌ │
# │   ▄▀▒   ░░██░▓▓█  ░██░░▓█  ██▓▒██   ██░░▓█▄   ▌ │
# │ ▒███████▒░██░▒▒█████▓ ░▒▓███▀▒░ ████▓▒░░▒████▓  │
# │ ░▒▒ ▓░▒░▒░▓  ░▒▓▒ ▒ ▒  ░▒   ▒ ░ ▒░▒░▒░  ▒▒▓  ▒  │
# │ ░░▒ ▒ ░ ▒ ▒ ░░░▒░ ░ ░   ░   ░   ░ ▒ ▒░  ░ ▒  ▒  │
# │ ░ ░ ░ ░ ░ ▒ ░ ░░░ ░ ░ ░ ░   ░ ░ ░ ░ ▒   ░ ░  ░  │
# │   ░ ░     ░     ░           ░     ░ ░     ░     │
# │ ░                                       ░       │
# │                                                 │
# └─────────────────────────────────────────────────┘
