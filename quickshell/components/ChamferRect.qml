// Angular panel with chamfered (cut) corners - ZZZ style
import QtQuick

Rectangle {
    id: root
    property int chamfer: 8
    property color fillColor: "#1e1e28"
    property color strokeColor: "#2f2f3d"
    property int strokeWidth: 1

    color: "transparent"

    // Drawn via Canvas for chamfered corners
    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var w = width, h = height, c = root.chamfer;
            ctx.beginPath();
            ctx.moveTo(c, 0);
            ctx.lineTo(w - c, 0);
            ctx.lineTo(w, c);
            ctx.lineTo(w, h - c);
            ctx.lineTo(w - c, h);
            ctx.lineTo(c, h);
            ctx.lineTo(0, h - c);
            ctx.lineTo(0, c);
            ctx.closePath();
            ctx.fillStyle = root.fillColor;
            ctx.fill();
            if (root.strokeWidth > 0) {
                ctx.lineWidth = root.strokeWidth;
                ctx.strokeStyle = root.strokeColor;
                ctx.stroke();
            }
        }
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }
}