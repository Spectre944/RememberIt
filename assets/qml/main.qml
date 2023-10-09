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
                    fileManagerContext.saveBufferVocabSignal(wordPage.textAreaBufferAlias.text, wordPage.textAreaTranslateAlias.text)
                }
            }
            Action {
                text: qsTr("Merge all vocabulary to one");
                onTriggered: {
                    fileManagerContext.mergeBackupFilesToVocaburarySignal()
                    wordPage.textAreaTranslateAlias.clear()
                    wordPage.textAreaBufferAlias.clear()
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

    SwipeView {
        id: pageView
        anchors.fill: parent
        currentIndex: 0

        WordTestPage {
            id: testPage
        }

        WordLibraryPage {
            id: wordPage
        }

        SettingPage {
            id: settingPage
        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
