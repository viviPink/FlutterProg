import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Решаем квадратики',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() {
    return _FirstScreenState();
  }
}

class _FirstScreenState extends State<FirstScreen> {
  // берем значения с формы для а в и с 
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  // согласие на обработку данных
  bool _isAgreed = false;

// метод проверки данных => второй экран если все в порядке
  void _navigateToSecondScreen(BuildContext context) {
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
    //если нет галочки  
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(a: a, b: b, c: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ввод коэффициентов'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              // текущее значение
              controller: _aController,
              // labelText :Добавляет метку (label)
              // над текстовым полем
              // Метка "поднимается" вверх, когда 
              //пользователь начинает вводить текст
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

class SecondScreen extends StatelessWidget {
  final double a, b, c;

  SecondScreen({required this.a, required this.b, required this.c});

  List<String> calculateRoots() {
    double discr = b * b - 4 * a * c;
    if (discr > 0) {
      double root1 = (-b + sqrt(discr)) / (2 * a);
      double root2 = (-b - sqrt(discr)) / (2 * a);
      return ['Два корня: ${root1.toStringAsFixed(2)} и ${root2.toStringAsFixed(2)}'];
    } else if (discr == 0) {
      double root = -b / (2 * a);
      return ['Один корень: ${root.toStringAsFixed(2)}'];
    } else {
      return ['Нет корней'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Уравнение: ${a}x² + ${b}x + $c = 0'),
            SizedBox(height: 20),
            for (String root in calculateRoots()) Text(root),
          ],
        ),
      ),
    );
  }
}