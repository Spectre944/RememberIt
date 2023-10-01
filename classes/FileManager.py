# This Python file uses the following encoding: utf-8
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal


class FileManagerClass(QtCore.QObject):

    def __init__(self):
        super().__init__()

    # Signal to send data in TextEdit // In QML need to connect target: fileManagerContext and create function onUpdateBuffer
    updateBufferSlot = Signal(str)

    @QtCore.Slot(str, str)
    def saveBufferVocabSignal(self, strBuff, strVoc):
        # Read all content and send to QML
        output_file = "Vocabulary.txt"

        # Split to lines
        buf_lines = strBuff.splitlines()
        voc_lines = strVoc.splitlines()
        print(buf_lines)
        print(voc_lines)

        # Check if content lines is equal
        if len(buf_lines) != len(voc_lines):
            print("Количество строк в strBuf и strVoc не совпадает.")
            return

        # Write new string word - translate
        new_lines = [f"{buf_line.strip()} - {voc_line.strip()}" for buf_line, voc_line in zip(buf_lines, voc_lines)]
        print(new_lines)

        # Save new strings to file
        with open(output_file, "w", encoding="utf-8") as file:
            file.write("\n".join(new_lines))


    # Recive signal from UI by timer or click to update TextEdit
    @QtCore.Slot()
    def updateBufferSignal(self):

        # Read all content and send to QML
        input_file_path = "WordBuffer.txt"
        with open(input_file_path, "r") as file:
            content = file.read()

        self.updateBufferSlot.emit(str(content))


