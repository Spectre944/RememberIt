# This Python file uses the following encoding: utf-8
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal, Slot, Qt, QAbstractListModel, QModelIndex

import random
import re

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

        # model
        self.wordTestModel = WordListModel([])

    returnRandomWordUSl = Signal(str, str)

    @QtCore.Slot()
    def getRandomWordUSi(self):
        # Чтение данных из файла "Vocabulary.txt"
        with open(self.VocabFName, "r", encoding="utf-8") as vocab_file:
            lines = vocab_file.readlines()

        # Извлечение случайных 4 пар слово-перевод
        random_lines = random.sample(lines, 4)

        for i in range(len(random_lines)):
            random_lines[i] = re.sub(' +', ' ', random_lines[i]).strip()

        # Разделение на слово и перевод и создание списка пар
        word_translation_pairs = [line.strip().split(" - ") for line in random_lines]

        # Выбор случайного слова (вопрос  - ответ)
        randomWord = word_translation_pairs[0][0]  # Выберите первое слово из списка
        answerWord = word_translation_pairs[0][1]

        # Обновление текста в TextEdit
        self.returnRandomWordUSl.emit(randomWord, answerWord)

        # Перемешивание пар, чтобы правильный ответ не всегда был на одной позиции
        random.shuffle(word_translation_pairs)

        # Создание списка для модели
        random_words = [pair[1] for pair in word_translation_pairs]  # Используйте переводы в модели

        # Обновление модели
        self.wordTestModel.updateModel(random_words)




