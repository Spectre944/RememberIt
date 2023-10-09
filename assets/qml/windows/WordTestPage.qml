import QtQuick
import QtQuick.Controls

Page {

    Timer {
        id: delayTimer
        interval: 300
        onTriggered: {
            //get new words after correct answer with delay
            wordRandomizerContext.getRandomWordUSi();
        }
    }

    Rectangle {
        id: rectangleWordTest
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            radius: 10
            color: "#f0f0f0"

            Text {
                id: textAnserWord
                y: textRandomWord.y
                anchors.left: helpQuestion.right
                anchors.margins: 10
                width: 200
                height: 20
                visible: false
                text: ""
            }

            Text {
                id: textRandomWord
                anchors.horizontalCenter: parent.horizontalCenter
                width: 200
                height: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: ""

            }

            RoundButton {
                id: helpQuestion
                y: textRandomWord.y
                width: 20
                height: 20
                anchors.left: textRandomWord.right
                text: "?"
                onClicked: {
                    textAnserWord.visible = true
                }
            }

            ListView {
                id: listViewWordTest
                model: wordTestModel
                width: parent.width
                height: 300
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter



                delegate: Rectangle {

                    width: 200
                    height: 50
                    color: "#0000ffff"
                    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined

                    Rectangle {
                        id: wordSlot
                        anchors.fill: parent
                        anchors.margins: 5
                        radius: 10
                        color: "#e09617"

                        MouseArea {
                            id: choseMouseArea
                            anchors.fill: parent
                            onClicked: {
                                if(choseText.text == textAnserWord.text){
                                    wordSlot.color = "#6be017"
                                    delayTimer.start()
                                    textAnserWord.visible = false
                                    //wordRandomizerContext.getRandomWordUSi()
                                }
                                else {
                                    wordSlot.color = "#cf4500"
                                }
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


    Connections {
        target: wordRandomizerContext

        function onGetRandomWordUSi(){

        }

        function onReturnRandomWordUSl(question, asnwer){
            textRandomWord.text = question
            textAnserWord.text = asnwer
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:4}
}
##^##*/
