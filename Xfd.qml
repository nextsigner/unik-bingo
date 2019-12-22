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
        id: gridNums
        spacing: app.fs*0.5
        columns: 10
        anchors.centerIn: parent
        Repeater{
            model: 90
            XNum{
                num:parseInt(index+1)>9?''+parseInt(index+1):'0'+parseInt(index+1)
                numReal:parseInt(index+1)
                Rectangle{
                    anchors.fill: parent
                    color: 'red'
                    opacity: app.arraNumerosDisponibles.indexOf(parent.num)>0?0.5:0.0
                }
            }
        }
    }
    UBgMetal{z:gridNums.z-1;opacity: 0.75}
    function retirarNumero(n){
        for(var i=0;i<gridNums.children.length;i++){
            //console.log('---->'+i+': '+gridNums.children[i].num)
            if(gridNums.children[i].numReal===n){
                gridNums.children[i].opacity=0.5
            }
        }
    }
}
