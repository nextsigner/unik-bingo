import QtQuick 2.0

Rectangle {
    id: r
    border.width: unikSettings.borderWidth
    border.color: app.c1
    radius: width*0.5
    width: app.fs*3.5
    height: width
    color: app.c2
    property alias num: txtNum.text
    property int numReal
    Text{
        id: txtNum
        anchors.centerIn: parent
        color: app.c1
        font.pixelSize: parent.width*0.6
    }
}
