#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==> Garbanzo System installer"

# Dependencies (Arch/CachyOS)
if command -v pacman >/dev/null 2>&1; then
    echo "==> Installing dependencies..."
    sudo pacman -S --needed --noconfirm \
        hyprland hyprlock hypridle quickshell-git qt6-base qt6-declarative \
        kitty thunar firefox grim slurp wl-clipboard swww \
        brightnessctl pamixer networkmanager bluez blueman \
        ttf-jetbrains-mono-nerd noto-fonts 2>/dev/null || true
fi

# Copy Hyprland config
echo "==> Installing Hyprland config..."
mkdir -p "$CONFIG_DIR/hypr"
cp -r "$REPO_DIR/hypr/"* "$CONFIG_DIR/hypr/"

# Copy Quickshell config
echo "==> Installing Quickshell config..."
mkdir -p "$CONFIG_DIR/quickshell/garbanzo"
cp -r "$REPO_DIR/quickshell/"* "$CONFIG_DIR/quickshell/garbanzo/"

# Hyprland layer config path expected by hyprland.conf
mkdir -p "$CONFIG_DIR/quickshell/garbanzo"
cp "$REPO_DIR/quickshell/hyprland-layer-config.conf" "$CONFIG_DIR/quickshell/garbanzo/" 2>/dev/null || true

echo "==> Done. Add 'exec-once = qs -c garbanzo' to your Hyprland config (already in autostart.conf)."
echo "==> Reload Hyprland or log in again."