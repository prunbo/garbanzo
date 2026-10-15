pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property string ssid: "Offline"
    property bool connected: false

    function refresh() { netProc.running = true; }

    property Process netProc: Process {
        command: ["sh", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
        running: false
        stdout: SplitParser {
            onRead: data => {
                var s = data.trim();
                root.ssid = s.length ? s : "Offline";
                root.connected = s.length > 0;
            }
        }
    }

    Component.onCompleted: root.refresh()

    property Timer timer: Timer {
        interval: 5000
        repeat: true
        running: true
        onTriggered: root.refresh()
    }
}