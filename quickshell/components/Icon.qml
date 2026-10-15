// Simple icon label using Material Symbols
import QtQuick
import "../config" as Config

Text {
    id: root
    property string name: ""
    property int size: 18
    property color color: Config.Theme.text

    text: name
    font.family: Config.Theme.fontIcon
    font.pixelSize: size
    color: root.color
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}