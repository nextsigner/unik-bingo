import QtQuick 2.0
import QtGraphicalEffects 1.12
Item {
    id: r
    anchors.fill: parent
    Image {
        id: fondo3
        source: "file://"+unik.currentFolderPath()+'/img/fondo-rect-1.png'
        anchors.fill: r
        antialiasing: true
        opacity: 0.65
        visible: false
    }
    FastBlur {
        anchors.fill: fondo3
        source: fondo3
        radius: 10
    }

}
