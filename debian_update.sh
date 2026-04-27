#!/usr/bin/env bash

set -e

echo ">> Starting system maintenance..."

sudo apt update && sudo apt full-upgrade -y

sudo apt autoremove --purge -y && sudo apt autoclean

if ! command -v fastfetch &>/dev/null; then
    echo ">> Installing fastfetch via APT..."
    sudo apt install -y fastfetch || echo ">> Fastfetch not found in current repos."
fi

fastfetch

if [ -f /var/run/reboot-required ]; then
    echo ">> [WARNING] A reboot is required to apply kernel updates."
fi
