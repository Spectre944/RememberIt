import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Page {
        id: controllPage
        anchors.fill: parent

        Rectangle {
            id: background
            anchors.fill: parent
            color: "white"

            Rectangle {
                id: content
                anchors.fill: parent
                anchors.margins: 10
                color: "lightgray"
                radius: 10

                Rectangle {
                    id: leftFrame
                    width: parent.width/2
                    color: "#10ff0000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                }

                Rectangle {
                    id: rightFrame
                    color: "#1000ff00"
                    anchors.left: leftFrame.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                }

                Button {
                    id: buttonSaveBufferToVocab
                    text: qsTr("Save buffer")
                    onClicked: {
                        fileManagerContext.saveBufferToVocab("1", "2")
                    }
                }

            }
        }
    }


}
