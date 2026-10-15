pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property var workspaces: []
    property int activeId: 1

    function refresh() {
        wsProc.running = true;
    }

    property Process wsProc: Process {
        command: ["hyprctl", "-j", "workspaces"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var data = JSON.parse(this.text);
                    root.workspaces = data;
                } catch (e) {}
            }
        }
    }

    property Process activeProc: Process {
        command: ["hyprctl", "-j", "activeworkspace"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var data = JSON.parse(this.text);
                    root.activeId = data.id;
                } catch (e) {}
            }
        }
    }

    property Timer timer: Timer {
        interval: 500
        repeat: true
        running: true
        onTriggered: { root.refresh(); root.activeProc.running = true; }
    }
}