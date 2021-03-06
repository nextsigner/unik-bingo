import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id: r
    width: app.fs*6
    height: parent.parent.height
    property alias listModel: lm
    signal repetir(string n)
    ListView{
        id: lv
        model: lm
        delegate: del
        width: r.width
        height: r.height
        anchors.horizontalCenter: parent.horizontalCenter
        ListModel{
            id:lm
            function addNum(n){
                return{
                    num:n
                }
            }
        }
        Component{
            id: del
            Rectangle{
                id:xUNS2
                width: 0
                height: width
                radius: width*0.5
                color: app.c1
                border.width: app.fs*0.5
                border.color: app.c2
                Behavior on width{
                    NumberAnimation{
                        duration: 250
                        easing.type: Easing.OutBounce
                    }
                }
                Image {
                    id: fondo3
                    source: Qt.platform.os!=='windows'?"file://"+unik.currentFolderPath()+'/img/fondo-ficha-1.png':"file:///"+unik.currentFolderPath()+'/img/fondo-ficha-1.png'
                    anchors.fill: parent
                    antialiasing: true
                    opacity: 0.65
                    visible: false
                }
                FastBlur {
                    anchors.fill: fondo3
                    source: fondo3
                    radius: 10
                }
                Text {
                    id: txtNum
                    text: '<b>'+num+'</b>'
                    font.pixelSize: parent.width*0.45
                    color: app.c2
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        r.repetir((""+num).replace('<b>', '').replace('</b>', ''))
                    }
                }
                Component.onCompleted: {
                    xUNS2.width=r.width//-app.fs*0.25*index
                }                
            }
        }
    }
}
