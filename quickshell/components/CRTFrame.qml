// Chamfered CRT-style frame with neon border
import QtQuick
import "../config" as Config

Rectangle {
    id: root
    property color frameColor: Config.Theme.surface
    property color borderColor: Config.Theme.accent
    property int chamfer: 10

    color: frameColor
    border.color: borderColor
    border.width: 2

    // chamfered corners via clip path not available; use radius fallback
    radius: 0
}