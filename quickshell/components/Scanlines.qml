// CRT/VHS scanline overlay
import QtQuick
import "../config" as Config

Rectangle {
    id: root
    color: "transparent"
    // Draw horizontal scanlines
    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.fillStyle = "rgba(255,255,255," + Config.Theme.scanlineOpacity + ")";
            var step = Config.Theme.scanlineSpacing;
            for (var y = 0; y < height; y += step) {
                ctx.fillRect(0, y, width, 1);
            }
        }
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }
}