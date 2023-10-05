import QtQuick
import QtQuick.Controls

Rectangle {

    property color btnPressed: "#10ff0000"
    property color btnHover: "#10ffff00"
    property color btnTextColor: "#white"

    id: customBtn
    width: 50
    height: 25
    radius: 10
    color: btnHover

    Text {
        id: btnText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Button"
        color: btnTextColor
    }

    MouseArea {
        id: ma
        anchors.fill: parent

        onHoveredChanged: {

        }
    }



}


