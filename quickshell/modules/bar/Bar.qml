import QtQuick
import Quickshell
import Quickshell.Io
import "../config" as Config
import "../services" as Services
import "../components" as Components

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitHeight: Config.Theme.barHeight
                color: "transparent"

                // Background bar (ZZZ style: dark + neon yellow border + scanlines)
                Rectangle {
                    anchors.fill: parent
                    color: Config.Theme.bg
                    opacity: 0.9
                    border.color: Config.Theme.accent
                    border.width: 1
                }
                Components.Scanlines {
                    anchors.fill: parent
                    opacity: 0.5
                }

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: Config.Theme.spacingMd
                    anchors.rightMargin: Config.Theme.spacingMd
                    spacing: Config.Theme.spacingMd

                    // Left: workspaces + window title
                    Row {
                        spacing: Config.Theme.spacingSm
                        anchors.verticalCenter: parent.verticalCenter

                        // Workspaces
                        Repeater {
                            model: Services.Workspaces.workspaces
                            delegate: Rectangle {
                                required property var modelData
                                width: 26; height: 26
                                radius: 4
                                color: modelData.id === Services.Workspaces.activeId
                                       ? Config.Theme.accent : Config.Theme.surface
                                border.color: Config.Theme.border
                                border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.id
                                    font.family: Config.Theme.fontUi
                                    font.bold: true
                                    font.pixelSize: 12
                                    color: modelData.id === Services.Workspaces.activeId ? "#000" : Config.Theme.text
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: Quickshell.execDetached(["hyprctl", "dispatch", "workspace", String(modelData.id)])
                                }
                            }
                        }
                    }

                    // Center: clock
                    Item {
                        width: parent.width - 520
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter

                        Column {
                            anchors.centerIn: parent
                            spacing: 0
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: Services.Clock.time
                                font.family: Config.Theme.fontMono
                                font.bold: true
                                font.pixelSize: 15
                                color: Config.Theme.text
                            }
                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: Services.Clock.weekday + "  " + Services.Clock.date
                                font.family: Config.Theme.fontUi
                                font.pixelSize: 10
                                color: Config.Theme.textMuted
                            }
                        }
                    }

                    // Right block
                    Row {
                        id: rightBlock
                        spacing: Config.Theme.spacingSm
                        anchors.verticalCenter: parent.verticalCenter
                        layoutDirection: Qt.RightToLeft

                        // Notifications
                        Components.ZzzButton {
                            iconName: "notifications"
                            onClicked: Quickshell.execDetached(["qs", "-c", "garbanzo", "ipc", "call", "notifications", "toggle"])
                        }
                        // Audio
                        Row {
                            spacing: 4
                            anchors.verticalCenter: parent.verticalCenter
                            Text {
                                text: Services.Audio.muted ? "volume_off" : "volume_up"
                                font.family: Config.Theme.fontIcon
                                font.pixelSize: 18
                                color: Config.Theme.text
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text {
                                text: Services.Audio.volume + "%"
                                font.family: Config.Theme.fontMono
                                font.pixelSize: 11
                                color: Config.Theme.textMuted
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        // Network
                        Text {
                            text: Services.Network.connected ? "wifi" : "wifi_off"
                            font.family: Config.Theme.fontIcon
                            font.pixelSize: 18
                            color: Config.Theme.text
                            verticalAlignment: Text.AlignVCenter
                        }
                        // Battery
                        Row {
                            spacing: 4
                            anchors.verticalCenter: parent.verticalCenter
                            Text {
                                text: Services.Battery.charging ? "battery_charging_full" : "battery_full"
                                font.family: Config.Theme.fontIcon
                                font.pixelSize: 18
                                color: Config.Theme.text
                                verticalAlignment: Text.AlignVCenter
                            }
                            Text {
                                text: Services.Battery.percent + "%"
                                font.family: Config.Theme.fontMono
                                font.pixelSize: 11
                                color: Config.Theme.textMuted
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        // Tray placeholder
                        Text {
                            text: "more_horiz"
                            font.family: Config.Theme.fontIcon
                            font.pixelSize: 18
                            color: Config.Theme.textMuted
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }
}