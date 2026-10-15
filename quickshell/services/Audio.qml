pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property int volume: 0
    property bool muted: false

    function refresh() { volProc.running = true; }
    function setVolume(v) {
        setProc.command = ["pamixer", "--set-volume", String(v)];
        setProc.running = true;
    }
    function toggleMute() { muteProc.running = true; }

    property Process volProc: Process {
        command: ["pamixer", "--get-volume"]
        running: false
        stdout: SplitParser { onRead: data => { var n = parseInt(data); if (!isNaN(n)) root.volume = n; } }
    }
    property Process muteProc: Process {
        command: ["pamixer", "-t"]
        running: false
        onExited: root.refresh()
    }
    property Process setProc: Process {
        running: false
        onExited: root.refresh()
    }

    Component.onCompleted: root.refresh()

    property Timer timer: Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: root.refresh()
    }
}