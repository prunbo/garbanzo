pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property string time: "--:--"
    property string date: ""
    property string weekday: ""

    property var _proc: null

    Component.onCompleted: {
        timer.running = true;
        update();
    }

    function update() {
        dateProc.running = true;
    }

    property Process dateProc: Process {
        command: ["date", "+%H:%M|%A|%d/%m/%Y"]
        running: false
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split("|");
                root.time = parts[0] || root.time;
                root.weekday = parts[1] || root.weekday;
                root.date = parts[2] || root.date;
            }
        }
    }

    property Timer timer: Timer {
        interval: 1000
        repeat: true
        onTriggered: root.update()
    }
}