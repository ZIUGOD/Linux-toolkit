#!/usr/bin/env bash

set -e

echo ">> Starting system maintenance..."

sudo apt update && sudo apt full-upgrade -y

sudo apt autoremove --purge && sudo apt autoclean

if ! command -v fastfetch &>/dev/null; then
    echo ">> Installing fastfetch via APT..."
    sudo apt install fastfetch || echo ">> Fastfetch not found in current repos."
fi

fastfetch

if [ -f /var/run/reboot-required ]; then
    echo ">> [WARNING] A reboot is required to apply kernel updates."
    read -r -p ">> Do you want to reboot now? (y/N) " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        sudo reboot
    else
        echo ">> Please remember to reboot as soon as possible to ensure your system is secure and up-to-date."
    fi
fi
