import QtQuick
import Quickshell
import Quickshell.Io
import "../config" as Config

Scope {
    id: root
    property bool visible: false

    IpcHandler {
        target: "launcher"
        function toggle() { root.visible = !root.visible; }
        function show() { root.visible = true; }
        function hide() { root.visible = false; }
    }

    // Full-screen overlay
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                anchors { top: true; bottom: true; left: true; right: true }
                color: "transparent"
                visible: root.visible

                // Backdrop
                Rectangle {
                    anchors.fill: parent
                    color: "#000000"
                    opacity: 0.55
                    MouseArea { anchors.fill: parent; onClicked: root.visible = false }
                }

                // Panel
                Rectangle {
                    anchors.centerIn: parent
                    width: 720
                    height: 520
                    radius: Config.Theme.radiusLg
                    color: Config.Theme.bgAlt
                    border.color: Config.Theme.accent
                    border.width: 2

                    Column {
                        anchors.fill: parent
                        anchors.margins: Config.Theme.spacingLg
                        spacing: Config.Theme.spacingMd

                        Text {
                            text: "GARBANZO LAUNCHER"
                            font.family: Config.Theme.fontUi
                            font.bold: true
                            font.pixelSize: 20
                            color: Config.Theme.accent
                        }

                        // Search
                        Rectangle {
                            width: parent.width
                            height: 36
                            radius: Config.Theme.radius
                            color: Config.Theme.surface
                            border.color: Config.Theme.border
                            border.width: 1
                            TextInput {
                                id: search
                                anchors.fill: parent
                                anchors.margins: 8
                                color: Config.Theme.text
                                font.family: Config.Theme.fontUi
                                font.pixelSize: 14
                                placeholderText: "Search apps..."
                                placeholderTextColor: Config.Theme.textMuted
                            }
                        }

                        // Grid
                        GridView {
                            id: grid
                            width: parent.width
                            height: parent.height - 80
                            cellWidth: 120
                            cellHeight: 110
                            model: ListModel {
                                ListElement { name: "Firefox"; icon: "public" }
                                ListElement { name: "Thunar"; icon: "folder" }
                                ListElement { name: "Kitty"; icon: "terminal" }
                                ListElement { name: "VS Code"; icon: "code" }
                                ListElement { name: "Spotify"; icon: "music_note" }
                                ListElement { name: "Settings"; icon: "settings" }
                            }
                            delegate: Rectangle {
                                width: 110
                                height: 100
                                radius: Config.Theme.radius
                                color: ma.containsMouse ? Config.Theme.surfaceAlt : "transparent"
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: icon
                                        font.family: Config.Theme.fontIcon
                                        font.pixelSize: 36
                                        color: Config.Theme.accent
                                    }
                                    Text {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: name
                                        font.family: Config.Theme.fontUi
                                        font.pixelSize: 12
                                        color: Config.Theme.text
                                    }
                                }
                                MouseArea {
                                    id: ma
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        root.visible = false;
                                        Quickshell.execDetached(["sh", "-c", name.toLowerCase().replace(" ", "")]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}