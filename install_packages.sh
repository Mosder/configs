#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(pwd)"

CORE_EXTRA="packages/core_extra"
MULTILIB="packages/multilib"
AUR="packages/aur"

distinct_echo() {
    echo
    printf '%.s-' {1..80}; echo

    for msg in "$@"; do
        echo "$msg"
    done

    printf '%.s-' {1..80}; echo
    echo
}

install_yay() {
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si
    cd "$SCRIPT_DIR"
    rm -rf /tmp/yay
}

distinct_echo "Ensuring keyring and dbs are synced..."
sudo pacman -Sy archlinux-keyring

distinct_echo "Upgrading system..."
sudo pacman -Syu

distinct_echo "Installing core/extra packages..."
sudo pacman -S $(cat "$CORE_EXTRA")

distinct_echo "Installing multilib packages (aka steam)..." "Make sure you have multilib enabled in /etc/pacman.conf"
sudo pacman -S $(cat "$MULTILIB")

if which yay &>/dev/null; then
    distinct_echo "Updating yay..."
    yay -S yay
else
    distinct_echo "Yay not found. Installing..."
    install_yay
fi

distinct_echo "Installing AUR packages..." "(Hopefully they're not infected lol)"
yay -S $(cat "$AUR")

echo -e "\nDone."
