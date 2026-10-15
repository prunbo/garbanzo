import QtQuick
import Quickshell
import "../config" as Config
import "../services" as Services

Scope {
    id: root
    property bool visible: false
    property string icon: "volume_up"
    property int value: 0
    property var hideTimer: null

    function show(iconName, val) {
        root.icon = iconName;
        root.value = val;
        root.visible = true;
        if (root.hideTimer) root.hideTimer.restart();
    }

    IpcHandler {
        target: "osd"
        function volume() { root.show("volume_up", Services.Audio.volume); }
        function brightness() { root.show("brightness_high", 50); }
    }

    Variants {
        model: Quickshell.screens
        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData
                // full width so the inner panel can be centered
                anchors { bottom: true; left: true; right: true }
                margins { bottom: 120 }
                implicitHeight: 60
                color: "transparent"
                visible: root.visible

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 220
                    height: 52
                    radius: Config.Theme.radiusLg
                    color: Config.Theme.bgAlt
                    border.color: Config.Theme.accent
                    border.width: 1

                    Row {
                        anchors.centerIn: parent
                        spacing: 12
                        Text {
                            text: root.icon
                            font.family: Config.Theme.fontIcon
                            font.pixelSize: 24
                            color: Config.Theme.accent
                            verticalAlignment: Text.AlignVCenter
                        }
                        Column {
                            spacing: 4
                            Text {
                                text: root.value + "%"
                                font.family: Config.Theme.fontMono
                                font.bold: true
                                font.pixelSize: 14
                                color: Config.Theme.text
                            }
                            Rectangle {
                                width: 120
                                height: 6
                                radius: 3
                                color: Config.Theme.surface
                                Rectangle {
                                    width: parent.width * (root.value / 100)
                                    height: parent.height
                                    radius: 3
                                    color: Config.Theme.accent
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Timer {
        interval: 1500
        running: root.visible
        onTriggered: root.visible = false
    }
}