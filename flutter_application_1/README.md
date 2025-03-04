## Данная инструкция описывает процесс установки и настройки среды разработки для работы с Flutter на пк на Windows. 
Все действия выполняются в соответствии с официальной документацией Flutter .

---

## 1. Установка Flutter SDK
1. Скачан архив Flutter SDK с официального сайта:  
   [Flutter Downloads](https://flutter.dev/docs/get-started/install/windows#install-the-flutter-sdk)

2. Распован архив

3. Добавлен путь к Flutter в системные переменные окружения:
   -**Переменные среды**- В разделе "Системные переменные" - в переменную `Path` и добавить путь к каталогу `bin` внутри папки Flutter 


## 2. Установка VS Code

1. Скачан и установлен редактор кода Visual Studio Code:  
   [VS Code Download](https://code.visualstudio.com/Download)

2. После установки в VS Code установлены следующие расширения:
   - **Dart**: Для поддержки языка программирования Dart
   - **Flutter**: Для интеграции с Flutter SDK


## 3. Установка Android Studio

1. Скачаан и установите Android Studio:  
   [Android Studio Download](https://developer.android.com/studio)

2. Запущен Android Studio и выполните первоначальную настройку.

3. В менеджере SDK (`File` → `Settings` → `Appearance & Behavior` → `System Settings` → `Android SDK`) установлены следующие компоненты:
   - **Android SDK Platform** для API уровня 35 (или выше).
   - **Android SDK Build-Tools**.
   - **Command-line Tools (latest)**.
   - 
4. Проверка установки
2. В терминале выполнить команду:
   ```bash
   flutter doctor
Команда проверит состояние установки и выведет список возможных проблем

---

## 4. Создание первого проекта
- Открsnm VS Code
- Нажать сочетание клавиш Shift + Ctrl + P и выберите команду Flutter: New Project и создать проект
  ### Выбор устройства для запуска
- Shift + Ctrl + P и Flutter: Select Device
- Из списка доступных устройств выберать запущенный эмулятор
- Нажмите клавишу F5, чтобы запустить проект

