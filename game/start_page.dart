import 'package:flutter/material.dart';
import 'home_page.dart';


//- StatelessWidget - это виджет без внутреннего состояния. Это означает, что он всегда будет отображаться одинаково, независимо от изменений в приложении или внешних данных. Эти виджеты подходят для отображения статического контента или данных, которые не меняются со временем.
//- StatefulWidget - это виджет с внутренним состоянием. Его внешний вид может меняться в зависимости от изменений во внутреннем состоянии. Эти виджеты используются для создания интерактивных компонентов пользовательского интерфейса, таких как кнопки, формы ввода данных и анимации.


// Класс StartPage представляет начальную страницу приложения
//будет отображать одно и тоже при обновлении 
class StartPage extends StatelessWidget {
  // Конструктор класса StartPage
  const StartPage({Key? key});

  @override
  // Метод build отвечает за построение и отображение виджета
  Widget build(BuildContext context) {
    return Scaffold(
      // Устанавливаем фоновый цвет начальной страницы
      backgroundColor: Color.fromARGB(255, 81, 131, 31),
      body: Column(
        // Выравниваем элементы по центру по вертикали
        mainAxisAlignment: MainAxisAlignment.center,
        // Выравниваем элементы по центру по горизонтали
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                //текст на кнопке
                const Text(
                  'Добро пожаловать!',
                  //стиль текста
                  style: TextStyle(
                    //размер
                    fontSize: 28,
                    //толщина шрифта
                    fontWeight: FontWeight.bold,
                    //цвет текста
                    color: Colors.white,
                  ),
                ),
                //расстояние между элементами
                SizedBox(
                  height: 15,
                ),
                Text(
                    '🐍',
                    style: TextStyle(fontSize: 60),
                  ),
                // Кнопка для начала игры
                // ElevatedButton(
                //   //стиль
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color.fromRGBO(142, 191, 37, 1),
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                //   ),
                //   //нажатие
                //   onPressed: () {},
                //   child: Text(
                //     '🐍',
                //     style: TextStyle(fontSize: 30),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Выберите скорость игры:',
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //одинаковый размер
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(142, 191, 37, 1),
                    ),
                  ),
                  //при нажатии
                  onPressed: () {
                    // вызывается метод push у класса Navigator,
                    // который отвечает за навигацию между экранами (страницами) в приложении Flutter
                    Navigator.push(
                      context,
                      // создается новый объект класса MaterialPageRoute, который представляет
                      // маршрут (переход) к новой странице. Этот класс принимает builder в качестве параметра
                      MaterialPageRoute(
                        //определяется функция-конструктор builder, которая создает новый виджет HomePage при переходе по маршруту
                        builder: (context) => HomePage(
                          //key: UniqueKey() - передается уникальный ключ для нового экземпляра виджета HomePage.
                          // Это необходимо для правильного обновления виджета в дереве виджетов.
                          key: UniqueKey(),
                          gameDuration: 500,
                        ),
                      ),
                    ).then((value) {
                      //_HomePageState(gameDuration: 500); // Медленная скорость (500 мс)
                    });
                  },
                  child: Text(
                    'Медленно',
                    //стиль текста

                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(191, 168, 37, 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          key: UniqueKey(),
                          gameDuration: 300,
                        ),
                      ),
                    ).then((value) {
                      //_HomePageState(gameDuration: 300); // Средняя скорость (300 мс)
                    });
                  },
                  child: Text(
                    'Средне',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(191, 37, 37, 0.788),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          key: UniqueKey(),
                          gameDuration: 100,
                        ),
                      ),
                    ).then((value) {
                      //_HomePageState(gameDuration: 100); // Быстрая скорость (100 мс)
                    });
                  },
                  child: Text(
                    'Быстро',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
