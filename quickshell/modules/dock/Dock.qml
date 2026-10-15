import QtQuick
import Quickshell
import "../config" as Config
import "../services" as Services

Scope {
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                anchors {
                    bottom: true
                    left: true
                    right: true
                }
                implicitHeight: Config.Theme.dockHeight
                color: "transparent"

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    width: dockRow.implicitWidth + Config.Theme.spacingLg * 2
                    height: Config.Theme.dockIconSize + Config.Theme.spacingMd * 2
                    radius: 0
                    color: Config.Theme.bg
                    opacity: 0.9
                    border.color: Config.Theme.accent
                    border.width: 1

                    Row {
                        id: dockRow
                        anchors.centerIn: parent
                        spacing: Config.Theme.spacingSm

                        Repeater {
                            model: Config.Config.dockPinned
                            delegate: Rectangle {
                                required property string modelData
                                width: Config.Theme.dockIconSize
                                height: Config.Theme.dockIconSize
                                radius: Config.Theme.radius
                                color: Config.Theme.surface
                                border.color: Config.Theme.border
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.charAt(0).toUpperCase()
                                    font.family: Config.Theme.fontUi
                                    font.bold: true
                                    font.pixelSize: 20
                                    color: Config.Theme.accent
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: parent.color = Config.Theme.surfaceAlt
                                    onExited: parent.color = Config.Theme.surface
                                    onClicked: Quickshell.execDetached(["sh", "-c", modelData])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}