import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
   // берем значения с формы для а в и с 
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
   // согласие на обработку данных
  bool _isAgreed = false;

  void _navigateToSecondScreen(BuildContext context) {
    // метод проверки данных => второй экран если все в порядке

    // Метод double.tryParse пытается преобразовать
    // текст в число типа double. Если текст некорректный
    // (например, "abc" или пустую строку), метод вернет null.
    double? a = double.tryParse(_aController.text);
    double? b = double.tryParse(_bController.text);
    double? c = double.tryParse(_cController.text);


    // SnackBar — это всплывающее сообщение в нижней
    // части экрана, которое информирует пользователя 
    if (a == null || b == null || c == null) {
      // ScaffoldMessenger.of(context).showSnackBar(...) 
      //отвечает за отображение уведомления на экране
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('циферки, надо циферки')),
      );
      return;
    }

    if (a == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('1й коэффициент не должен быть равен 0')),
      );
      return;
    }

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('надо галочку поставить')),
      );
      return;
    }



    // Navigator.push:
    //Это метод Flutter, который используется
    // для перехода на новый экран
    // Он добавляет новый экран в стек навигации, 
    //позволяя пользователю вернуться на предыдущий экран
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Введите коэффициенты'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // labelText :Добавляет метку (label)
              // над текстовым полем
              // Метка "поднимается" вверх, когда 
              //пользователь начинает вводить текст
          children: [
            TextField(
               // текущее значение
              controller: _aController,
              decoration: InputDecoration(labelText: 'Введите a (x^2)'),
            ),
            TextField(
              controller: _bController,
              decoration: InputDecoration(labelText: 'Введите b (x)'),
            ),
            TextField(
              controller: _cController,
              decoration: InputDecoration(labelText: 'Введите c'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    // меняем значение для согласия
                    setState(() {
                      _isAgreed = value!;
                    });
                  },
                ),
                Text('Я согласен на обработку данных'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToSecondScreen(context);
              },
              child: Text('Посчитать корни'),
            ),
          ],
        ),
      ),
    );
  }
}