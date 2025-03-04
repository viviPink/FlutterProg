//Пинчукова Гера ИВТ-22

//класс для визуального оформления игры
//границы поля, цвета элементом и кнопки управления описываются 

import 'package:flutter/material.dart';
import 'shakeGameEngine.dart';
import 'values.dart';


//StatefulWidget- виджет с переменным состоянием
//используется для создания виджетов, которые могут изменять свое внутреннее состояние (state) в ответ на различные события
class HomePage extends StatefulWidget {
  // final - это ключевое слово, которое используется для объявления неизменяемой (константной) переменной
  //в отличие от const final может быть инициализировано во время выполнения программы
  final int gameDuration;
  // super(key: key) - это вызов конструктора родительского класса (StatefulWidget в данном случае)
  //required требуемое поле для создание класса
  //конструктор виджета 
  const HomePage({Key? key, required this.gameDuration}) : super(key: key);

//@override - это аннотация в Dart, которая указывает, что следующий за ней метод переопределяет метод с таким же именем в суперклассе

//является соответствующим объектом State. _HomePageState управляет состоянием игры,
// такими как позиция змейки, счет и положение еды, и использует setState() для обновления этого состояния

//создаем состояние виджета
//_HomePageState(gameDuration) только в этом классе доступен
  @override 
  //=> _HomePageState(gameDuration) - это синтаксис стрелочной функции в Dart, который создает анонимную функцию,
  // которая возвращает новый экземпляр _HomePageState с переданным значением gameDuration
  //состояние виджета 
  _HomePageState createState() => _HomePageState(gameDuration);
}

//Класс _HomePageState расширяет State<HomePage> и управляет внутренним состоянием виджета HomePage
//row и column (размеры игрового поля),
//borderList (список позиций границ игрового поля),
// shakePosition (список позиций змейки),
//snakeHead (позиция головы змейки),
//score (текущий счет игрока),
// direction (текущее направление движения змейки)
// food (экземпляр класса Food для управления едой)
//extends- наследует 
//State<HomePage> - состояние виджета HomePage
class _HomePageState extends State<HomePage> {
  //принимает gameDuration через конструктор
  final int gameDuration;
  //создаем объект с послед инициализацией 
  late SnakeGameEngine snakeTheGame;
  _HomePageState(this.gameDuration);

//Метод initState() вызывается при создании виджета и используется для инициализации состояния.
// В этом случае он создает экземпляр Food и вызывает метод startGame(), который начинает новую игру
  @override
  void initState() {
    // super Это гарантирует, что любая логика инициализации, определенная в суперклассе, также будет выполнена
    //суперкласса в методе initState() класса наследника
    super.initState();

    //инициалтзируем объект игры------------------------> с помощью консотруктора 
    snakeTheGame = SnakeGameEngine(
      gameDuration: gameDuration,
      showGameOver: showGameOver,
      //функция обноления состояния виджета  передается состояние страницы(виджета)
      setStateFunction: () {
        //setState - это метод, который используется 
        //для уведомления фреймворка об изменениях внутреннего состояния (state) 
        //виджета и перерисовки виджета с обновленным состоянием.
        setState(() {});
      },
    );
    snakeTheGame.startGame();
  }

// показывает то что игра закончена
  void showGameOver() {
    //тображает модальный диалог AlertDialog с сообщением "Game Over" и кнопкой "Restart".
    // Когда пользователь нажимает кнопку "Restart", диалог закрывается с помощью Navigator.of(context).pop(),
    // и вызывается метод startGame() для начала новой игры
    //функция которая отображает диалоговое окно 
    showDialog(
      // расположении виджета в древе виджетов
      //поверх
      context: context,
      //диалоговое окно нельзя закрыть, нажав вне его границ
      barrierDismissible: false,
      //анонимная функция, которая строит и возвращает виджет, который будет отображаться внутри диалогового окна
      builder: (context) {
        //виджет в Flutter, который представляет собой модальное диалоговое окно
        return AlertDialog(
          //заголовок
          title: const Text(
            "Game Over",
            style: TextStyle(
              //стиль текста 
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, //текст по центру
          ),
          //текст в центре 
          content: const Text("Your snake is RIP", textAlign: TextAlign.center,), //содержимое внутри
          //действия с кнопкой
          actions: [
            Row(
              //MainAxisAlignment.spaceEvenly - это одно из значений перечисления MainAxisAlignment, 
              //которое указывает, что дочерние виджеты должны быть равномерно распределены 
              //вдоль главной оси с равными промежутками между ними и между краями контейнера
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  //при нажатии
                  onPressed: () {
                    //это метод в Flutter, который используется для закрытия текущего экрана
                    //(диалогового окна, страницы или другого виджета) и возврата к предыдущему экрану в стеке навигации
                    
                    //Navigator.of(context).pop() - это метод в Flutter,
                    // который используется для удаления верхнего экрана (страницы)
                    // из стека навигатора и возвращения к предыдущему экрану
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    snakeTheGame.gameOver();
                  },
                  // child является дочерним виджетом для TextButton
                  child: const Text("Go to Menu"),
                ),
                TextButton(
                  //при нажатии
                  onPressed: () {
                    //это метод в Flutter, который используется для закрытия текущего экрана
                    //(диалогового окна, страницы или другого виджета) и возврата к предыдущему экрану в стеке навигации
                    Navigator.of(context).pop();
                    snakeTheGame.startGame();
                  },
                  // child является дочерним виджетом для TextButton
                  child: const Text("Restart"),
                ),
              ],
            )
          ],
        );
      },
    );
  }

//Метод build() создает и возвращает виджет Scaffold, который является основным контейнером для пользовательского интерфейса игры
//Он содержит Column с двумя дочерними виджетами: _buildGameView() (который преобразует игровое поле)
// и _buildGameControls() (преобразует элементы управления игрой)
  @override
  Widget build(BuildContext context) {
    //создает новый виджет Scaffold, который является базовой структурой для экрана приложения
    return Scaffold(
      //тело
      body: Column(
        //все  не в 1 чтобы не прокручивался
        children: [
          //виджет Expanded заставляет своего дочернего виджета (_buildGameView()) 
          //занимать все доступное пространство
          Expanded(child: _buildGameView()),
          _buildGameControls(),
        ],
      ),
    );
  }

//Метод _buildGameView() создает и возвращает GridView.builder,
//который отображает игровое поле как сетку квадратов.
//Он использует SliverGridDelegateWithFixedCrossAxisCount для
// настройки количества столбцов в сетке (crossAxisCount: column).
//Для каждого элемента в сетке (itemBuilder) он создает Container
//с закругленными углами и цветом, определенным методом fillBoxColor(index).
// Количество элементов в сетке равно row * column.

//отрисовка игры (обновление игры )
//список делится по строкам к примеру 3 на 3 
// в списке это [1 2 3 4 5 6 7 8 9 ]
//будет :[ 1 2 3
//         4 5 6
//         7 8 9 ]
  Widget _buildGameView() {
    //GridView(сетка).builder это виджет Flutter, который создает сетку элементов (в данном случае квадратных контейнеров динамически)
    return GridView.builder(
      //здесь определяется, как элементы будут размещены в сетке
      gridDelegate:
      //означает, что сетка будет иметь фиксированное количество (crossAxisCount) элементов в каждой строке, заданное переменной column
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column),
        //itemBuilder колбэк-функция, которая вызывается для построения каждого элемента сетки
              //параметры функции BuildContext предоставляет информацию о местоположении виджета в дереве виджетов, а index - индекс 
              //текущего элемента, который нужно построить
      itemBuilder: (context, index) {
        return Container(
          //это свойстваS, которые определяют внешний вид и отступы для виджета Container.
          margin: const EdgeInsets.all(1),
          //это класс, который позволяет задавать различные декоративные свойства для виджета, такие как цвет фона, границы, тени 
          decoration: BoxDecoration(
            //радиус контейнера (то что они не квадратные)
            borderRadius: BorderRadius.circular(8),
            //передаем индексы каждого элемента и проверяем что это 
            //и если этот индекс равен чему-то то мы возвращаем цвет соответ элемента 
            color: fillBoxColor(index),
          ),
        );
      },
      //работает до конца количества row * column
      itemCount: row * column,
    );
  }

//тут отрисовывается все в игре 
  // установка цвета для элементов в игре
  Color fillBoxColor(int index) {
    //установка цвета для змейки
    //ссылаемся на объект класса snakeTheGame
    if (snakeTheGame.shakePosition.contains(index)) {
      return Color.fromARGB(255, 13, 150, 40);
      //границы игрового поля
    } else if (snakeTheGame.borderList.contains(index)) {
      return Color.fromARGB(255, 111, 195, 114);
      //цвет еды
    } else if (index == snakeTheGame.food.foodPosition) {
      return Color.fromARGB(255, 181, 66, 9);
    } else {
      //цвет игрового поля
      return Color.fromARGB(255, 224, 208, 193);
    }
  }

  // Виджет _buildGameControls отвечает за отображение элементов управления игрой
  //отображение кнопочек
  Widget _buildGameControls() {
    return Column(
      // Выравниваем элементы по центру по вертикали
      //mainAxisAlignment типо у
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Отображаем текущий счет игры
        //это виджет, который добавляет отступы вокруг своего дочернего виджета (внутренее прстранство)
        Padding(
          //EdgeInsets класс который отвечает за расстояние (10 пикселей сверху внутренней границы)
          padding: const EdgeInsets.only(top: 10),
          //то что туда передаем 
          child: Text(
            //текст с очками 
            "Score: ${snakeTheGame.score}",
            //стиль текста 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        // Кнопка для перемещения вверх
        IconButton(
          //обязательный параметр
          onPressed: () {
            // Меняем направление движения, если текущее направление не вниз
            if (snakeTheGame.direction != Direction.down) {
              snakeTheGame.direction = Direction.up;
            }
          },
          //иконнка из коллекции иконок из библиотеки
          icon: const Icon(Icons.arrow_circle_up),
          //размер
          iconSize: 70,
        ),
        Row(
          // Выравниваем элементы по центру по горизонтали
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопка для перемещения влево
            IconButton(
              onPressed: () {
                // Меняем направление движения, если текущее направление не вправо
                if (snakeTheGame.direction != Direction.right) {
                  snakeTheGame.direction = Direction.left;
                }
              },
              icon: const Icon(Icons.arrow_circle_left_outlined),
              iconSize: 70,
            ),
            // Добавляем промежуток между кнопками
            const SizedBox(width: 100),
            IconButton(
              // Кнопка для перемещения вправо
              onPressed: () {
                if (snakeTheGame.direction != Direction.left) {
                  snakeTheGame.direction = Direction.right;
                }
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              iconSize: 70,
            ),
          ],
        ),
        // Кнопка для перемещения вниз
        IconButton(
          onPressed: () {
            if (snakeTheGame.direction != Direction.up) {
              snakeTheGame.direction = Direction.down;
            }
          },
          icon: const Icon(Icons.arrow_circle_down_outlined),
          iconSize: 70,
        ),
      ],
    );
  }
}
