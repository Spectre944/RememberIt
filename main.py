# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


from classes.WordManager import WordManagerClass
from classes.FileManager import FileManagerClass
from classes.WordRandomizer import WordRandomizerClass

if __name__ == "__main__":

    # Create class for work with words and clipboard
    wm = WordManagerClass()

    # Create class for work with file and text
    fm = FileManagerClass()

    # Class to extract random words from Vovab
    wr = WordRandomizerClass()

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Add connections to QML
    engine.rootContext().setContextProperty("fileManagerContext", fm)
    engine.rootContext().setContextProperty("wordManagerContext", wm)
    engine.rootContext().setContextProperty("wordRandomizerContext", wr)
    # Add model
    engine.rootContext().setContextProperty("wordTestModel", wr.wordTestModel)

    engine.load(os.fspath(Path(__file__).resolve().parent / "assets/qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
