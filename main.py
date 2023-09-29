# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine


from classes.WordManager import WordManagerClass
from classes.FileManager import FileManagerClass


if __name__ == "__main__":

    # Create class for work with words and clipboard
    wm = WordManagerClass()

    # Create class for work with file and text
    fm = FileManagerClass()

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Добавьте экземпляр FileManager в контекст QML
    engine.rootContext().setContextProperty("fileManagerContext", fm)

    engine.load(os.fspath(Path(__file__).resolve().parent / "assets/qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
