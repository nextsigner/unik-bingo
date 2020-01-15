import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.12
import QtMultimedia 5.12
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.12
ApplicationWindow{
    id: app
    visibility: "Maximized"
    color: c3
    width: Screen.width
    height: Screen.height
    property int fs: Screen.width*0.02*unikSettings.zoom
    property color c1
    property color c2
    property color c3
    property color c4
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}
    Settings{
        id: appSettings
        property int currentNumColor:2
    }
    UnikSettings{
        id: unikSettings
        url: './unik-bingo.json'
        Component.onCompleted: {
            unikSettings.currentNumColor=appSettings.currentNumColor
            unikSettings.zoom=0.7
            console.log('Cantidad de Temas: '+unikSettings.defaultColors.split('|').length)
            var mc=unikSettings.defaultColors.split('|')[unikSettings.currentNumColor]
            var colors=mc.split('-')
            app.c1=colors[0]
            app.c2=colors[1]
            app.c3=colors[2]
            app.c4=colors[3]
            app.fs= Screen.width*0.016*unikSettings.zoom
        }
    }
    Audio{
        id:mp
        source: './audio/dingdong.wav'
    }
    Audio{
        id:mp2
    }
    Audio{
        id:mpRepeat
        playlist: Playlist {
            id: playlistRepeat
        }
    }
    Timer{
        id: tPlayVoz
        interval: 1000
        onTriggered: mp2.play()
    }
    Item {
        id: xApp
        anchors.fill: parent
        Column{
            anchors.centerIn: parent
            spacing: app.fs*0.5
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs
                Text {
                    id: txtUNunSort
                    text: "Elegir Cartones"
                    font.pixelSize: app.fs
                    color: app.c2
                    width: rowAreasPrincipales.width/3-app.fs
                }
                Item{
                    width: rowAreasPrincipales.width/4-app.fs
                    height: 1
                }
                Text {
                    id: txtCantNunSort
                    text: "Todavìa no se ha sorteado ningùn nùmero."
                    font.pixelSize: app.fs
                    color: app.c2
                    width: rowAreasPrincipales.width/3-app.fs
                }
            }
            Row{
                id:rowAreasPrincipales
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: app.fs
                Xfd{id:xfd}
                Item{
                    id:xUNS
                    width: 1
                    height: 1
                    z:xfs.z+1
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    Rectangle{
                        id:xFRed
                        width: app.fs*10
                        height: width
                        color: app.c2
                        radius: width*0.5
                        anchors.centerIn: parent
                        border.width: app.fs*0.3
                        border.color: 'red'
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(labelUNum.text==='Iniciar'){
                                    xAvisoDeComienzo.visible=true
                                    return
                                }
                                tPlayVoz.stop()
                                playlistRepeat.clear()
                                playlistRepeat.addItem( "file://"+unik.currentFolderPath()+"/audio/repeat.flac")
                                playlistRepeat.addItem( "file://"+unik.currentFolderPath()+"/audio/repeatLast.flac")
                                playlistRepeat.addItem("file://"+unik.currentFolderPath()+"/audio/"+labelUNum.text.replace('<b>', '').replace('</b>', '')+".flac")
                                playlistRepeat.currentIndex=0
                                mpRepeat.play()
                            }
                        }
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
                        Image {
                            id: fondo
                            source: Qt.platform.os!=='windows'?"file://"+unik.currentFolderPath()+'/img/fondo-ficha-1.png':"file:///"+unik.currentFolderPath()+'/img/fondo-ficha-1.png'
                            anchors.fill: parent
                            antialiasing: true
                            opacity: 0.65
                            visible: false
                        }
                        FastBlur {
                            anchors.fill: fondo
                            source: fondo
                            radius: 10
                        }
                        Text{
                            id: labelUNum
                            text:'Iniciar'
                            font.pixelSize: text==='Iniciar'?parent.width*0.15:parent.width*0.45
                            color: app.c1
                            anchors.centerIn: parent
                            onTextChanged: anNNS.start()
                        }
                        Text{
                            id: labelUNum2
                            text:labelUNum.text
                            font.pixelSize: text==='Iniciar'?parent.width*0.15:parent.width*0.45
                            color: 'white'
                            anchors.centerIn: parent
                            opacity: fred.width>fred.parent.width*0.8?1.0:0.0
                            Behavior on opacity{NumberAnimation{duration: 250}}
                        }
                        Text{
                            visible: labelUNum.text!=='Iniciar'
                            text:'<b>Ùltimo</b><br><b>Nùmero</b>'
                            font.pixelSize: parent.width*0.08
                            horizontalAlignment: Text.AlignHCenter
                            textFormat: Text.RichText
                            color: app.c1
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: labelUNum.top
                            anchors.bottomMargin: 0-app.fs*0.75
                        }
                    }
                    Xfa{
                        id: xfa
                        anchors.top: xUNS.bottom
                        anchors.topMargin: xFRed.width*0.5+unikSettings.borderWidth
                        anchors.horizontalCenter: parent.horizontalCenter
                        onRepetir: {
                            tPlayVoz.stop()
                            playlistRepeat.clear()
                            playlistRepeat.addItem( "file://"+unik.currentFolderPath()+"/audio/repeat.flac")
                            playlistRepeat.addItem("file://"+unik.currentFolderPath()+"/audio/"+n+".flac")
                            playlistRepeat.currentIndex=0
                            mpRepeat.play()
                        }
                    }

                }
                Xfs{
                    id:xfs
                }
            }
            Row{
                XControl{
                    text: tAuto.running?"\uf04c":"\uf04b"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: tAuto.running=!tAuto.running
                    }
                }
            }
        }
        Rectangle{
            id:xAvisoDeComienzo
            width: parent.width*0.5
            height: parent.height*0.5
            color: app.c2
            radius: app.fs
            border.color: app.c1
            border.width: app.fs*0.5
            anchors.centerIn: parent
            visible: false
            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                    tAuto.start()
                }
            }
            Text {
                id: txtAvisoDeComienzo
                text: 'El sorteo del Bingo está por comenzar. Por favor seleccionen los cartones'
                font.pixelSize: app.fs*2
                color: app.c1
                width: parent.width*0.8
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Space'
        onActivated: tAuto.running=!tAuto.running
    }
    Shortcut{
        sequence: 'Enter'
        onActivated: tAuto.running=!tAuto.running
    }
    Shortcut{
        sequence: 'Up'
        onActivated: sortearNumero()
    }
    Shortcut{
        sequence: 'Return'
        onActivated: tAuto.running=!tAuto.running
    }
    Timer{
        id: tAuto
        running: false
        repeat: true
        interval: 6000
        onTriggered: {
            xAvisoDeComienzo.visible=false
            sortearNumero()
        }
    }
    property var arraNumerosDisponibles: []
    property var arrayNumSort: []
    property int cantNumSort: 0
    function sortearNumero(){
        xAvisoDeComienzo.visible=false
        var num = Math.round(Math.random()*90);
        console.log('Num: '+num)
        for(var i=0;i<90;i++){
            if(xfd.children[0].children[i].numReal===num&&xfd.children[0].children[i].opacity>0.25){
                xfd.children[0].children[i].opacity=0.25
                xfs.children[0].children[i].opacity=1.0
                if(labelUNum.text!=='Iniciar'){
                    xfa.listModel.insert(0,xfa.listModel.addNum(labelUNum.text))
                }
                var num2Dig=num>9?''+num:'0'+num
                labelUNum.text='<b>'+num2Dig+'</b>'
                cantNumSort++
                txtCantNunSort.text=app.cantNumSort>1?'Se han sorteado '+app.cantNumSort+' nùmeros':'Se ha sorteado '+app.cantNumSort+' nùmero'
                mp.play()
                mp2.source = './audio/'+num2Dig+'.flac'
                tPlayVoz.start()
            }else{
                if(xfd.children[0].children[i].numReal===num&&xfd.children[0].children[i].opacity===0.25){
                    sortearNumero()
                }
            }
        }
    }

    Component.onCompleted: {
        for(var i=0;i<90;i++){
            arraNumerosDisponibles.push(i)
            arrayNumSort[i]=[]
            arrayNumSort[i][0]=-1
        }
        console.log('arrayNumSort: '+arrayNumSort)
    }
}
