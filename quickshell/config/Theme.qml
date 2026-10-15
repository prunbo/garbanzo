// Garbanzo System - ZZZ-inspired theme tokens
// Singleton. Import as: import "config" as Config (or via qmldir)
pragma Singleton
import QtQuick

QtObject {
    // Palette (Zenless Zone Zero - retro-futurista / VHS / CRT)
    readonly property color bg:          "#0d0d12"
    readonly property color bgAlt:       "#16161d"
    readonly property color surface:     "#1e1e28"
    readonly property color surfaceAlt:  "#262633"
    readonly property color border:      "#2f2f3d"
    readonly property color accent:      "#ffb300"   // amarelo neon (primary)
    readonly property color accent2:     "#ff6b00"   // laranja
    readonly property color accentGlow:  "#ffb30066"
    readonly property color cyan:        "#00e5ff"   // ciano neon
    readonly property color magenta:     "#ff3bd4"   // magenta
    readonly property color lime:        "#b6ff00"   // verde-limao
    readonly property color success:     "#3ddc84"
    readonly property color warning:     "#ffcc00"
    readonly property color danger:      "#ff3b3b"
    readonly property color text:        "#f5f5f5"
    readonly property color textMuted:   "#8a8a9a"

    // Scanline / CRT
    readonly property real scanlineOpacity: 0.06
    readonly property int scanlineSpacing: 3

    // Geometry (angular / chamfered)
    readonly property int radius: 6
    readonly property int radiusLg: 10
    readonly property int borderWidth: 1
    readonly property int barHeight: 40
    readonly property int dockIconSize: 48
    readonly property int dockHeight: 72

    // Spacing
    readonly property int spacingXs: 4
    readonly property int spacingSm: 8
    readonly property int spacingMd: 12
    readonly property int spacingLg: 16

    // Fonts
    readonly property string fontMono: "JetBrains Mono Nerd Font"
    readonly property string fontUi:   "Rajdhani"
    readonly property string fontIcon:  "Material Symbols Rounded"

    // Animation durations (ms)
    readonly property int animFast: 120
    readonly property int animMed:  220
    readonly property int animSlow: 360
}