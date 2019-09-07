import QtQuick 2.0

Rectangle {
    id: r
    border.width: unikSettings.borderWidth
    border.color: app.c2
    radius: unikSettings.radius*0.25
    width: app.width*0.5-app.fs*3
    height: app.height-app.fs*9
    color: app.c1
    Grid{
        id: gridNumsSort
        spacing: app.fs*0.5
        columns: 10
        anchors.centerIn: parent
        Repeater{
            id: repNS
            model: 100
            XNum{
                num:index>9?''+index:'0'+index
                opacity:0.25
                numReal:index
                /*Rectangle{
                    anchors.fill: parent
                    color: 'red'
                    opacity: app.arraNumerosDisponibles.indexOf(parent.num)>0?0.5:0.0
                }*/
            }
        }
    }
    function updateSort(){
        var narray=app.arrayNumSort
        repNS.model=narray
    }
}
