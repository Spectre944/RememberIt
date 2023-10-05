import QtQuick
import QtQuick.Controls

Window {
    id: notificationWindow
    visible: true
    x: 500
    y: 100
    width: 300
    height: 100
    flags: Qt.WindowStaysOnTopHint



    Item {
        height: parent.height
        width: parent.width

        Rectangle {
            id: background
            anchors.fill: parent
            color: "#00000000"

            Rectangle {
                id: content
                anchors.fill: parent
                anchors.margins: 10
                radius: 10
                color: "lightgray"

                Image {
                    id: imgAccepted
                    height: parent.height
                    width: 50

                }

                Text {
                    id: lableText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.left: imgAccepted.right
                    anchors.right: undoButton.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 0
                    text: "Word saved"
                }

                Button {
                    id: undoButton
                    width: 50
                    text: "Undo"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 0

                }

            }
        }

        Connections {
            target: wordManagerContext

            function onTextSaveUndoSlot(str){
                notificationWindow.visible = true
                lableText.text = str
                console.log(str)

            }
        }



    }

}


