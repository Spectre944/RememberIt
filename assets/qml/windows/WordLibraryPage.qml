import QtQuick
import QtQuick.Controls


Page {

    property alias textAreaBufferAlias: textAreaBuffer
    property alias textAreaTranslateAlias: textAreaTranslate

    Rectangle {
        id: background
        anchors.fill: parent
        color: "white"

        Rectangle {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            color: "#f0f0f0"
            radius: 10

            Rectangle {
                id: leftFrame
                color: "#1000ff00"
                anchors.left: parent.left
                anchors.right: rectangleSplitter.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10

                ScrollView {
                    id: scrollView
                    anchors.fill: parent
                    anchors.topMargin: 0

                    TextArea {
                        id: textAreaBuffer
                        anchors.fill: parent
                        placeholderText: qsTr("Saved words by user")
                    }
                }
            }

            Rectangle {
                id: rightFrame
                color: "#1000ff00"
                anchors.left: rectangleSplitter.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 10
                anchors.leftMargin: 10
                anchors.topMargin: 10

                ScrollView {
                    id: scrollView1
                    anchors.fill: parent

                    TextArea {
                        id: textAreaTranslate
                        anchors.fill: parent
                        placeholderText: qsTr("Translation of buffer place here")
                    }
                }
            }

            Rectangle {
                id: rectangleSplitter
                width: 0
                height: parent.height
                color: "#ffffff"
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }
    }

    Connections {
        target: fileManagerContext

        function onUpdateBufferSlot(str){
            textAreaBuffer.text = str
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}
}
##^##*/
