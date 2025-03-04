// Импортируем необходимый пакет для работы с Flutter
import 'package:flutter/material.dart';
// Импортируем файл start_page.dart, содержащий виджет StartPage
import 'start_page.dart';

// Точка входа в приложение
void main() {
  // Запускаем приложение и передаем виджет MainApp в качестве корневого
  runApp(const MainApp());
}

// Класс MainApp является корневым виджетом приложения  который наследуется от StatelessWidget
class MainApp extends StatelessWidget {
  // Конструктор класса MainApp
  const MainApp({super.key});

  @override
  // Метод build отвечает за построение и отображение виджета
  Widget build(BuildContext context) {
    // Возвращаем виджет MaterialApp, который является корневым виджетом 
    //Material Design
    return MaterialApp(
      // Убираем отметку в правом верхнем углу, показывающую режим отладки
      debugShowCheckedModeBanner: false,
      // Устанавливаем темную тему для приложения
      theme: ThemeData.dark(),
      // Устанавливаем виджет StartPage в качестве начальной страницы приложения
      home: StartPage(),
    );
  }
}
