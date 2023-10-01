import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "windows"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    NotificationWindow {
        id: notification
        visible: false
    }

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

                    ScrollView {
                        id: scrollView
                        anchors.fill: parent

                        TextArea {
                            id: textAreaBuffer
                            anchors.fill: parent
                            placeholderText: qsTr("Text Area")
                        }
                    }
                }

                Rectangle {
                    id: rightFrame
                    color: "#1000ff00"
                    anchors.left: leftFrame.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10

                    ScrollView {
                        id: scrollView1
                        anchors.fill: parent

                        TextArea {
                            id: textAreaTranslate
                            placeholderText: qsTr("Text Area")
                        }
                    }
                }

                Button {
                    id: buttonSaveBufferToVocab
                    x: 543
                    y: 10
                    text: qsTr("Save buffer")
                    onClicked: {
                        fileManagerContext.saveBufferVocabSignal(textAreaBuffer.text, textAreaTranslate.text)
                    }
                }

                Button {
                    id: buttonLoadBuffer
                    x: 530
                    y: 34
                    width: 80
                    height: 28
                    text: qsTr("Load buffer")

                    onClicked: {
                        fileManagerContext.updateBufferSignal()
                    }
                }

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
