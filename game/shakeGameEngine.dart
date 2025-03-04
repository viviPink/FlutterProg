//Пинчуковаа Гера ИВТ-22

//Класс логики игры 
import 'dart:async';
import 'food.dart';
import 'values.dart';

class SnakeGameEngine {
  //края игрового поля создается списком номеров элементов и в создании окна делается в виде матрицы (row col)
  //в списке краев будет:{1 2 3 4 5...(до 20) 21 30 31 40 ...  }
  List<int> borderList = [];
  //змейка
  List<int> shakePosition = [];
  //голова змейки
  int _snakeHead = 0;
  //счет
  int score = 0;
  //направления змейки
  //late - тип переменной в которую позпозже запишется 
  late Direction direction;
  //late Food food = Food();
  late Food food;

  //булеан конца игры если игра закончена то фалс
  //нужен для того чтобы прекращать игру и выходить на стартовую страницу 
  bool _isGameOver = false;

  //сложность игры
  int gameDuration;

  //CallBack функции - это функции, которые передаются в качестве аргумента
  // другой функции и вызываются внутри этой функции позже
  //функция окончания игры
  Function showGameOver;
  //функция setState от виджета
  Function setStateFunction;


//конструктор класса
  SnakeGameEngine({
    //required это ключевое слово в Dart, которое указывает, что параметр конструктора должен быть обязательно передан при создании экземпляра класса
    required this.gameDuration,
    required this.showGameOver,
    required this.setStateFunction,
  });

// конец игры 
  void gameOver() {
    _isGameOver = true;
  }

//создаем еду там где нет границы
void checkPositionFood() {
  //устанавливаем флаг для того чтобы найти хорошую позицию
    bool validPosition = false;
    //проверяем что позиция подходит 
    while (!validPosition) {
        food.generateFood(row, column);
        //проверка что не совпадает с краями 
        if (!borderList.contains(food.foodPosition)) {
            validPosition = true;
        }
    }
}
  //устанавливает начальное состояние игры
  //таймер
  void startGame() {
    food = Food();
    //создание границ
    makeBorder();
    //генерация еды на поле
   checkPositionFood();
    //направление пути змейки
    direction = Direction.right;
    //позиция змейки в начале игры
    shakePosition = [ 44, 43, 42];
    //определяем голову змейки
    _snakeHead = shakePosition.first;
    //определяем скрорость змейки исходя из выбора на start_page
    
    //final - это ключевое слово, которое используется для объявления переменной,
    // которая может быть инициализирована только один раз и не может быть изменена в дальнейшем

    //gameDuration скорость обновления 
    final duration = Duration(milliseconds: gameDuration);
    //каждый промежуток времени вызывается обновление змейки 
    //вызывваать анонимную функцию таймер через интервал дуратион
    Timer.periodic(duration, (timer) {
      if (_isGameOver) {
        timer.cancel();
      }
      updateShake();
      //проверка на то что голова змейки не врезалась и не скушала еду
      //если да -> останавливаем игру
      if (checkCollision()) {
        timer.cancel();
        score = 0;
        showGameOver();
      }
    });
  }

//обновление направления движения змейки
  void updateShake() {
    //содержащий элементы исходного списка, начиная с указанного индекса
    //Таким образом, создается новый список, который исключает первый элемент из shakePosition.
    switch (direction) {
      //вверх
      case Direction.up:
      //insert(0, вставка в нулевую позицию(голову) элемента который будет расположен в _snakeHead - column
        shakePosition.insert(0, _snakeHead - column);
        break;
      //вниз
      case Direction.down:
        shakePosition.insert(0, _snakeHead + column);
        break;
      //право
      case Direction.right:
        shakePosition.insert(0, _snakeHead + 1);
        break;
      //лево
      case Direction.left:
        shakePosition.insert(0, _snakeHead - 1);
        break;
    }
    //если произошло изменение то вызвался сет и обновил виджет и переменные в нем 
    setStateFunction();
//проверка на то что голова змейки не на еде
    if (_snakeHead == food.foodPosition) {
      score++;
      food.generateFood(row, column);
      setStateFunction();
    } else {
      shakePosition.removeLast();
    }
    //голова змейки
    _snakeHead = shakePosition.first;
  }

  //порверка на то что змейка нне ударилась головой об края или же себя не скушала няма-няма
  bool checkCollision() {
    // края
    if (borderList.contains(_snakeHead)) return true;
    //себя

    //sublist(1): это метод в Dart, который возвращает новый список,
    //содержащий элементы исходного списка, начиная с указанного индекса
    //(в данном случае, с индекса 1, то есть со второго элемента).
    //Таким образом, создается новый список, который исключает первый элемент из shakePosition
    if (shakePosition.sublist(1).contains(_snakeHead)) return true;
    return false;
  }

  //создаем границы поля (строки, столбцы)
  void makeBorder() {
    for (int i = 0; i < row; i++) {
      borderList.add(i); //верхняя границы
      borderList.add(i * column); // лева границв
      borderList.add(i * column + column - 1); // правая граница
      borderList.add((row - 1) * column + i); // нижняя граница
    }
  }
  
}
