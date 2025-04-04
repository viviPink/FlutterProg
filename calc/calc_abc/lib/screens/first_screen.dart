import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'second_screen.dart';
import 'cubit/screen_cubit.dart'; // Путь к вашему Cubit

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // Контроллеры для текстовых полей
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();

  // Согласие на обработку данных
  bool _isAgreed = false;

  // Метод для перехода на второй экран с проверками
  void _navigateToSecondScreen(BuildContext context) {
    // Преобразуем введенные данные в числа
    double? a = double.tryParse(_aController.text);
    double? b = double.tryParse(_bController.text);
    double? c = double.tryParse(_cController.text);

    // Проверка на пустой ввод
    if (_aController.text.isEmpty ||
        _bController.text.isEmpty ||
        _cController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('не все циферкии')),
      );
      return;
    }

    // Проверка на корректность чисел
    if (a == null || b == null || c == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('введите только циферкии')),
      );
      return;
    }

    // Проверка на нулевой коэффициент "a"
    if (a == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Коэффициент "a" не должен быть равен 0')),
      );
      return;
    }

    // Проверка согласия на обработку данных
    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('потавь галочку')),
      );
      return;
    }

    // Если все проверки пройдены, передаем данные в Cubit
    context.read<RootsCubit>().calculateRoots(a, b, c);

    // Переходим на второй экран
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Введите коэффициенты'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _aController,
                decoration: InputDecoration(
                  labelText: 'Введите a (x²)',
                  errorText: _aController.text.isNotEmpty &&
                          double.tryParse(_aController.text) == null
                      ? 'Введите число'
                      : null,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _bController,
                decoration: InputDecoration(
                  labelText: 'Введите b (x)',
                  errorText: _bController.text.isNotEmpty &&
                          double.tryParse(_bController.text) == null
                      ? 'Введите число'
                      : null,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _cController,
                decoration: InputDecoration(
                  labelText: 'Введите c',
                  errorText: _cController.text.isNotEmpty &&
                          double.tryParse(_cController.text) == null
                      ? 'Введите число'
                      : null,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isAgreed,
                    onChanged: (value) {
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
      ),
    );
  }
}