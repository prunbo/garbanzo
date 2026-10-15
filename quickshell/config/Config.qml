pragma Singleton
import QtQuick
import Quickshell

QtObject {
    // Bar
    property int barHeight: 40
    property string barPosition: "top"

    // Dock
    property int dockIconSize: 48
    property var dockPinned: ["firefox", "thunar", "kitty", "code", "spotify"]

    // Launcher
    property int launcherColumns: 5

    // Wallpaper
    property string wallpaperDir: "~/Pictures/Wallpapers"
}