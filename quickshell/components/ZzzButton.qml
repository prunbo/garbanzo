import QtQuick
import "../config" as Config

Rectangle {
    id: root
    property string label: ""
    property string iconName: ""
    property bool active: false
    signal clicked()

    implicitWidth: row.implicitWidth + Config.Theme.spacingMd * 2
    implicitHeight: 32
    radius: Config.Theme.radius
    color: active ? Config.Theme.accent : Config.Theme.surface
    border.color: active ? Config.Theme.accent2 : Config.Theme.border
    border.width: 1

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Config.Theme.spacingSm

        Text {
            visible: root.iconName !== ""
            text: root.iconName
            font.family: Config.Theme.fontIcon
            font.pixelSize: 16
            color: root.active ? "#000" : Config.Theme.text
            verticalAlignment: Text.AlignVCenter
        }
        Text {
            visible: root.label !== ""
            text: root.label
            font.family: Config.Theme.fontUi
            font.pixelSize: 14
            font.bold: true
            color: root.active ? "#000" : Config.Theme.text
            verticalAlignment: Text.AlignVCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}