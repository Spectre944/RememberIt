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
        Menu {
            title: qsTr("Test")
            Action {
                text: qsTr("Update model");
                onTriggered: {
                    wordRandomizerContext.getRandomWordUSi()
                }
            }
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
                    color: "#1000ff00"
                    anchors.left: parent.left
                    anchors.top: rectangleWordTest.bottom
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
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
                    anchors.left: leftFrame.right
                    anchors.right: parent.right
                    anchors.top: rectangleWordTest.bottom
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    anchors.topMargin: 10

                    ScrollView {
                        id: scrollView1
                        anchors.fill: parent

                        TextArea {
                            id: textAreaTranslate
                            placeholderText: qsTr("Translation of buffer place here")
                        }
                    }
                }

                Rectangle {
                    id: rectangleWordTest
                    height: 200
                    color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 10

                    TextField {
                        id: textField
                        x: 9
                        y: 8
                        width: 152
                        height: 22
                        placeholderText: qsTr("Text Field")
                    }

                    ListView {
                        id: listViewWordTest
                        model: wordTestModel
                        x: 8
                        y: 40
                        width: 153
                        height: 160


                        delegate: Rectangle {
                            x: 5
                            width: 80
                            height: 40
                            color: "gray"
                            radius: 10

                            MouseArea {
                                id: choseMouseArea
                                anchors.fill: parent
                                onClicked: {

                                }
                            }

                            Text {
                                id: choseText
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: modelData
                            }
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

    Connections {
        target: wordRandomizerContext

        function onGetRandomWordUSi(){

        }
    }



}
