import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.12
ApplicationWindow{
    id: app
    visibility: "Maximized"
    color: c1
    width: Screen.width
    height: Screen.height
    property int fs: Screen.width*0.02*unikSettings.zoom
    property color c1
    property color c2
    property color c3
    property color c4
    UnikSettings{
        id: unikSettings
        url: './unik-bingo.json'
        Component.onCompleted: {
            var mc=unikSettings.defaultColors.split('|')[unikSettings.currentNumColor]
            var colors=mc.split('-')
            app.c1=colors[0]
            app.c2=colors[1]
            app.c3=colors[2]
            app.c4=colors[3]
            app.fs= Screen.width*0.02*unikSettings.zoom
        }
    }
    Item {
        id: xApp
        anchors.fill: parent
        Column{
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*3
                Text {
                    id: txtUNunSort
                    text: "Elegir Cartones"
                    font.pixelSize: app.fs*2
                    color: app.c2
                }
                Text {
                    id: txtCantNunSort
                    text: "Todavìa no se ha sorteado ningùn nùmero."
                    font.pixelSize: app.fs*2
                    color: app.c2
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: app.fs
                Xfd{id:xfd}
                Item{
                    id:xUNS
                    width: 1
                    height: 1
                    z:xfs.z+1
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*6
                    Rectangle{
                        id:xFRed
                        width: app.fs*12
                        height: width
                        color: app.c2
                        radius: width*0.5
                        anchors.centerIn: parent
                        Rectangle{
                            id:fred
                            width: 0
                            height: width
                            radius: width*0.5
                            color: 'red'
                            anchors.centerIn: parent
                            SequentialAnimation{
                                id: anNNS
                                running: false
                                NumberAnimation {
                                    target: fred
                                    property: "width"
                                    from: 0
                                    to: fred.parent.width
                                    duration: 500
                                    easing.type: Easing.InBounce
                                }
                                PauseAnimation {
                                    duration: 500
                                }
                                NumberAnimation {
                                    target: fred
                                    property: "width"
                                    from: fred.parent.width
                                    to: 0
                                    duration: 250
                                    easing.type: Easing.OutBounce
                                }
                            }
                        }
                        Text{
                            id: labelUNum
                            text:'-'
                            font.pixelSize: parent.width*0.6
                            color: app.c1
                            anchors.centerIn: parent
                            onTextChanged: anNNS.start()
                        }
                        Text{
                            id: labelUNum2
                            text:labelUNum.text
                            font.pixelSize: parent.width*0.6
                            color: 'white'
                            anchors.centerIn: parent
                            onTextChanged: anNNS.start()
                            opacity: fred.width>fred.parent.width*0.8?1.0:0.0
                            Behavior on opacity{NumberAnimation{duration: 250}}
                        }
                        Text{
                            text:'<b>Ùltimo</b><br><b>Nùmero</b>'
                            font.pixelSize: parent.width*0.1
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.RichText
                            color: app.c1
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: labelUNum.top
                            anchors.bottomMargin: 0-app.fs*1.5
                        }
                    }
                    Xfa{
                        id: xfa
                        anchors.top: xUNS.bottom
                        anchors.topMargin: xFRed.width*0.5+unikSettings.borderWidth
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }
                Xfs{
                    id:xfs
                }
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Up'
        onActivated: sortearNumero()
    }
    property var arraNumerosDisponibles: []
    property var arrayNumSort: []
    property int cantNumSort: 0
    function sortearNumero(){
        var num = Math.round(Math.random()*99);
        for(var i=0;i<100;i++){
            if(xfd.children[0].children[i].numReal===num&&xfd.children[0].children[i].opacity>0.25){
                xfd.children[0].children[i].opacity=0.25
                xfs.children[0].children[i].opacity=1.0
                if(labelUNum.text!=='-'){
                    xfa.listModel.insert(0,xfa.listModel.addNum(labelUNum.text))
                }
                labelUNum.text='<b>'+num+'</b>'
                cantNumSort++
                txtCantNunSort.text=app.cantNumSort>1?'Se han sorteado '+app.cantNumSort+' nùmeros':'Se ha sorteado '+app.cantNumSort+' nùmero'
            }else{
                if(xfd.children[0].children[i].numReal===num&&xfd.children[0].children[i].opacity===0.25){
                    sortearNumero()
                }
            }
        }
    }

    Component.onCompleted: {
        for(var i=0;i<100;i++){
            arraNumerosDisponibles.push(i)
            arrayNumSort[i]=[]
            arrayNumSort[i][0]=-1
        }
        console.log('arrayNumSort: '+arrayNumSort)
    }
}
