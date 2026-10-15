pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property int percent: 0
    property bool charging: false
    property bool present: true

    function refresh() { batProc.running = true; }

    property Process batProc: Process {
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null; echo '---'; cat /sys/class/power_supply/BAT0/status 2>/dev/null"]
        running: false
        stdout: SplitParser {
            property string buf: ""
            onRead: data => {
                // accumulate not needed; handle single read
            }
        }
    }

    // Simpler: use two processes
    property Process capProc: Process {
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 0"]
        running: false
        stdout: SplitParser { onRead: data => { var n = parseInt(data); if (!isNaN(n)) root.percent = n; } }
    }
    property Process statProc: Process {
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo Unknown"]
        running: false
        stdout: SplitParser { onRead: data => { root.charging = data.trim().toLowerCase() === "charging"; } }
    }

    property Timer timer: Timer {
        interval: 10000
        repeat: true
        running: true
        onTriggered: { root.capProc.running = true; root.statProc.running = true; }
    }

    Component.onCompleted: { root.capProc.running = true; root.statProc.running = true; }
}