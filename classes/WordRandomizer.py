# This Python file uses the following encoding: utf-8
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal, Slot, Qt, QAbstractListModel, QModelIndex

# USl - UI slot (transfer data to UI from Python)
# USi - UI signal (get data from UI into Pyton)

class WordListModel(QAbstractListModel):
    def __init__(self, words=[], parent=None):
        super().__init__(parent)
        self._words = words

    def rowCount(self, parent=QModelIndex()):
        return len(self._words)

    def data(self, index, role=Qt.DisplayRole):
        if role == Qt.DisplayRole:
            return self._words[index.row()]

    def roleNames(self):
        return {Qt.DisplayRole: b'display'}

    def setData(self, index, value, role=Qt.EditRole):
        if role == Qt.EditRole:
            self._words[index.row()] = value
            self.dataChanged.emit(index, index)
            return True
        return False

    def updateModel(self, new_words):
        self.beginResetModel()
        self._words = new_words
        self.endResetModel()


class WordRandomizerClass(QtCore.QObject):
    def __init__(self):
        super().__init__()

        # File names
        self.BufferFName = "WordBuffer.txt"
        self.VocabFName = "Vocabulary.txt"
        self.backup_folder = "backup"

        #model
        self.wordTestModel = WordListModel([1, 2, 3, 4])

    returnRandomWordUSl = Signal(str)

    @QtCore.Slot()
    def getRandomWordUSi(self):
        self.wordTestModel.updateModel([5, 6, 7, 8])
        # print("Model updated")




