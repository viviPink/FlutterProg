//класс для Еды на поле (foodPosition- позиция еды borderList- поле)
import 'dart:math';

//задается список там записывается число 
class Food {
  // Позиция еды на поле
  //late- переменная которая объявляется но определяется потом 
  late int foodPosition;
 

//генерация еды в рандомном месте на поле (row - строки coulmn- колонки)
  void generateFood(int row, int column) {
    //рандомное расположение
    foodPosition = Random().nextInt(row * column);
    // Если сгенерированная позиция совпадает с занятой позицией (границей)
    // if (borderList.contains(foodPosition)) {
    //   // Вызываем функцию generateFood рекурсивно, чтобы сгенерировать новую позицию
    //   generateFood(row, column);
    // } else {
    //    // Если позиция свободна, генерируем новую случайную позицию
    //   foodPosition = Random().nextInt( row * column);
    // }
  }
}
