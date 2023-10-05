import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "windows"

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Vocabulary")

    menuBar: MenuBar {
            Menu {
                title: qsTr("&File")
                Action {
                    text: qsTr("Update word buffer");
                    onTriggered: {
                        fileManagerContext.updateBufferSignal()
                    }
                }
                Action {
                    text: qsTr("Save buffer to vocabulary");
                    onTriggered: {
                        fileManagerContext.saveBufferVocabSignal(textAreaBuffer.text, textAreaTranslate.text)
                    }
                }
                Action {
                    text: qsTr("Merge all vocabulary to one");
                    onTriggered: {
                        fileManagerContext.mergeBackupFilesToVocaburarySignal()
                        textAreaTranslate.clear()
                        textAreaBuffer.clear()
                    }
                }
            }

            Menu {
                title: qsTr("&View")
                Action { text: qsTr("---") }

            }
            Menu {
                title: qsTr("&Help")
                Action { text: qsTr("&About") }
            }

        }

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
                            placeholderText: qsTr("Saved words by user")
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
                            placeholderText: qsTr("Translation of buffer place here")
                        }
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
