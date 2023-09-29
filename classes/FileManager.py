# This Python file uses the following encoding: utf-8
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal


class FileManagerClass(QtCore.QObject):

    def __init__(self):
        super().__init__()

    @QtCore.Slot(str, str)
    def saveBufferToVocab(self, strBuff, strVoc):
        # Обработка сигнала от кнопки
        print("Кнопка была нажата")
