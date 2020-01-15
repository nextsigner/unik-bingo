import QtQuick 2.0
import QtGraphicalEffects 1.12
Item {
    id: r
    anchors.fill: parent
    //color: 'red'
    //radius: 30
    Image {
        id: fondo3
        property bool rounded: true
        property bool adapt: true
        layer.enabled: rounded
        visible: false
        layer.effect: OpacityMask {
            maskSource: Item {
                width: fondo3.width
                height: fondo3.height
                Rectangle {
                    anchors.centerIn: parent
                    width: fondo3.adapt ? fondo3.width : Math.min(fondo3.width, fondo3.height)
                    height: fondo3.adapt ? fondo3.height : width
                    radius: 30//Math.min(width, height)
                }
            }
        }
        source: "file://"+unik.currentFolderPath()+'/img/fila-metal.jpeg'
        anchors.fill: r
        antialiasing: true
        opacity: 0.65
        //visible: false
    }
    /*FastBlur {
        anchors.fill: fondo3
        source: fondo3
        radius: 10
    }*/
}
