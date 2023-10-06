# This Python file uses the following encoding: utf-8
from PySide6 import QtCore
from PySide6.QtCore import QObject, Signal

import os
from datetime import datetime

class FileManagerClass(QtCore.QObject):

    def __init__(self):
        super().__init__()

        # File names
        self.BufferFName = "WordBuffer.txt"
        self.VocabFName = "Vocabulary.txt"
        self.backup_folder = "backup"

    # Signal to send data in TextEdit // In QML need to connect target: fileManagerContext and create function onUpdateBuffer
    updateBufferSlot = Signal(str)

    @QtCore.Slot(str, str)
    def saveBufferVocabSignal(self, strBuff, strVoc):
        # Split to lines
        buf_lines = strBuff.splitlines()
        voc_lines = strVoc.splitlines()
        # print(buf_lines)
        # print(voc_lines)

        # Check if content lines are equal
        if len(buf_lines) != len(voc_lines):
            print("Количество строк в strBuf и strVoc не совпадает.")
            return

        # Find the maximum length of the word in the buffer
        max_buf_length = max(len(buf_line.strip()) for buf_line in buf_lines)

        # Write new string word - translate with equal padding
        new_lines = [f"{buf_line.strip().ljust(max_buf_length)} - {voc_line.strip()}" for buf_line, voc_line in zip(buf_lines, voc_lines)]
        # print(new_lines)

        # Generate a filename based on the current date
        current_date = datetime.now().strftime("%d_%m_%Y")
        output_file = f"Vocaburary_{current_date}.txt"

        # Create a backup folder if it doesn't exist
        if not os.path.exists(self.backup_folder):
            os.makedirs(self.backup_folder)

        # Save new strings to the backup folder
        backup_path = os.path.join(self.backup_folder, output_file)
        with open(backup_path, "w", encoding="utf-8") as file:
            file.write("\n".join(new_lines))

        # Clear the WordBuffer.txt file
        with open(self.BufferFName, "w", encoding="utf-8") as word_buffer:
            word_buffer.write("")  # Write an empty string to clear the file


    # Recive signal from UI by timer or click to update TextEdit
    @QtCore.Slot()
    def updateBufferSignal(self):

        # Read all content and send to QML
        with open(self.BufferFName, "r") as file:
            content = file.read()

        self.updateBufferSlot.emit(str(content))

    @QtCore.Slot()
    def mergeBackupFilesToVocaburarySignal(self):

        # Получите список файлов в папке "backup"
        backup_files = os.listdir(self.backup_folder)

        # Откройте основной файл Vocabulary для записи
        with open(self.VocabFName, "w", encoding="utf-8") as main_file:
            for backup_file in backup_files:
                # Сформируйте полный путь к файлу в папке "backup"
                backup_file_path = os.path.join(self.backup_folder, backup_file)

                # Откройте файл в папке "backup" для чтения
                with open(backup_file_path, "r", encoding="utf-8") as backup_file:
                    # Скопируйте содержимое файла в основной файл Vocabulary
                    main_file.write(backup_file.read())

