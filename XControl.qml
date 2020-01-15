import QtQuick 2.0
import QtGraphicalEffects 1.12

Rectangle {
    id: r
    border.width: unikSettings.borderWidth
    border.color: app.c1
    radius: width*0.5
    width: app.fs*3
    height: width
    color: app.c2
    property alias text: txt.text
    antialiasing: true
    Image {
        id: fondo2
        source: Qt.platform.os!=='windows'?"file://"+unik.currentFolderPath()+'/img/fondo-ficha-1.png':"file:///"+unik.currentFolderPath()+'/img/fondo-ficha-1.png'
        anchors.fill: r
        antialiasing: true
        opacity: 0.65
    }
    FastBlur {
        anchors.fill: fondo2
        source: fondo2
        radius: 10
    }
    Text{
        id: txt
        anchors.centerIn: parent
        color: app.c1
        font.pixelSize: parent.width*0.5
        font.family: "FontAwesome"
    }
}
