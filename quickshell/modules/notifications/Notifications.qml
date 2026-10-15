import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import "../config" as Config

Scope {
    id: root
    property bool centerVisible: false
    property var toasts: []

    IpcHandler {
        target: "notifications"
        function toggle() { root.centerVisible = !root.centerVisible; }
        function show() { root.centerVisible = true; }
        function hide() { root.centerVisible = false; }
    }

    NotificationServer {
        id: server
        keepOnReload: true
        onNotification: (notif) => {
            notif.tracked = true;
            root.toasts = root.toasts.concat([notif]);
            toastTimer.restart();
        }
    }

    // Toast popups (top right)
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                anchors { top: true; right: true }
                margins { top: Config.Theme.barHeight + 8; right: 8 }
                implicitWidth: 320
                implicitHeight: toastCol.implicitHeight + 16
                color: "transparent"
                visible: root.toasts.length > 0

                Column {
                    id: toastCol
                    spacing: 8
                    Repeater {
                        model: root.toasts
                        delegate: Rectangle {
                            width: 304
                            height: 72
                            radius: Config.Theme.radius
                            color: Config.Theme.bgAlt
                            border.color: Config.Theme.accent
                            border.width: 1
                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 2
                                Text {
                                    text: modelData.appName || "Notification"
                                    font.family: Config.Theme.fontUi
                                    font.bold: true
                                    font.pixelSize: 12
                                    color: Config.Theme.accent
                                }
                                Text {
                                    text: modelData.summary || ""
                                    font.family: Config.Theme.fontUi
                                    font.bold: true
                                    font.pixelSize: 13
                                    color: Config.Theme.text
                                    elide: Text.ElideRight
                                    width: parent.width
                                }
                                Text {
                                    text: modelData.body || ""
                                    font.family: Config.Theme.fontUi
                                    font.pixelSize: 11
                                    color: Config.Theme.textMuted
                                    elide: Text.ElideRight
                                    width: parent.width
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: toastTimer
        interval: 5000
        onTriggered: root.toasts = []
    }

    // Center panel
    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                anchors { top: true; right: true }
                margins { top: Config.Theme.barHeight + 8; right: 8 }
                implicitWidth: 360
                implicitHeight: 480
                color: "transparent"
                visible: root.centerVisible

                Rectangle {
                    anchors.fill: parent
                    radius: Config.Theme.radiusLg
                    color: Config.Theme.bgAlt
                    border.color: Config.Theme.border
                    border.width: 1

                    Column {
                        anchors.fill: parent
                        anchors.margins: Config.Theme.spacingMd
                        spacing: Config.Theme.spacingSm
                        Text {
                            text: "NOTIFICATIONS"
                            font.family: Config.Theme.fontUi
                            font.bold: true
                            font.pixelSize: 16
                            color: Config.Theme.accent
                        }
                        Text {
                            text: root.toasts.length + " recent"
                            font.family: Config.Theme.fontUi
                            font.pixelSize: 12
                            color: Config.Theme.textMuted
                        }
                    }
                }
            }
        }
    }
}