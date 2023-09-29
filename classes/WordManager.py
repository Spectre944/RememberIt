# This Python file uses the following encoding: utf-8

import win32clipboard
import keyboard
import threading

# ##-----------------------------------------------------------------------## #


# ##-----------------------------------------------------------------------## #
class WordManagerClass():
    def __init__(self):

        self.data = ""
        self.clipboard_data = ""

        self.counter = 0
        self.saved = False

        # Регистрация обработчика для Ctrl + C
        keyboard.add_hotkey('ctrl+c', self.hotKeySaveWord)
        # Регистрация обработчика для Ctrl + Z
        keyboard.add_hotkey('ctrl+z', self.hotKeyUndoWord)

        # Создаем и запускаем отдельный поток
        keyboard_thread = threading.Thread(target=self.start_keyboard_listener)
        keyboard_thread.daemon = True  # Поток будет завершен при завершении основного потока
        keyboard_thread.start()


    def getClipboard(self):
        win32clipboard.OpenClipboard()
        data = win32clipboard.GetClipboardData()
        print(data)


    def hotKeySaveWord(self):

        self.counter += 1
        #print("data: {0} | clipboard: {1}".format(self.data, self.clipboard_data))
        #save to clipboard
        win32clipboard.OpenClipboard()
        self.clipboard_data = win32clipboard.GetClipboardData()

        if (self.counter == 2):
            self.data = win32clipboard.GetClipboardData()
            if (self.data == self.clipboard_data):
                print("Saving to file {0} - {1}".format(self.data, self.clipboard_data))
                self.save_to_file(self.data)
                self.saved = True
                self.counter = 0
            else:
                self.counter = 0

        win32clipboard.CloseClipboard()


    # Функция для запуска keyboard.wait() в отдельном потоке
    def start_keyboard_listener(self):
        print("Hotkey thread started")
        keyboard.wait()

    def save_to_file(self, text):
            # Здесь вы можете добавить код для записи текста в файл
            with open("WordBuffer.txt", "a") as file:
                file.write(text + "\n")
                self.counter = 0

    def hotKeyUndoWord(self):
        if (self.saved == True):

            input_file_path = "WordBuffer.txt"
            with open(input_file_path, "r") as file:
                content = file.read()

            # Search and delete the target word from the content
            modified_content = content.replace(self.data + "\n", "")

            # Open the input file for writing (this will overwrite the original file)
            with open(input_file_path, "w") as file:
                file.write(modified_content)
                self.saved = False
                print("Undo")




