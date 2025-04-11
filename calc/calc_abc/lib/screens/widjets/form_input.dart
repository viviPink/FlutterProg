import 'package:calc_abc/screens/cubit/screen_cubit.dart';
import 'package:calc_abc/screens/cubit/screev_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FormInput> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  bool _isAgreed = false;

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Поля ввода коэффициентов
        TextField(
          controller: _aController,
          decoration: InputDecoration(
            labelText: 'Коэффициент a (x²)',
            errorText:
                _aController.text.isNotEmpty &&
                        double.tryParse(_aController.text) == null
                    ? 'Введите число'
                    : null,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: _bController,
          decoration: InputDecoration(
            labelText: 'Коэффициент b (x)',
            errorText:
                _bController.text.isNotEmpty &&
                        double.tryParse(_bController.text) == null
                    ? 'Введите число'
                    : null,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        TextField(
          controller: _cController,
          decoration: InputDecoration(
            labelText: 'Коэффициент c',
            errorText:
                _cController.text.isNotEmpty &&
                        double.tryParse(_cController.text) == null
                    ? 'Введите число'
                    : null,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),

        // Чекбокс согласия
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
            Text('Согласен на обработку данных'),
          ],
        ),

        // Кнопка расчета
        ElevatedButton(
          onPressed: () => _calculateRoots(context),
          child: Text('Вычислить корни'),
        ),
      ],
    );
  }

  void _calculateRoots(BuildContext context) {
    // Проверка на заполненность полей
    if (_aController.text.isEmpty ||
        _bController.text.isEmpty ||
        _cController.text.isEmpty) {
      context.read<RootsCubit>().emit(
        RootsErrorState(errorMessage: 'Все поля должны быть заполнены'),
      );
      return;
    }

    // Проверка на числовые значения
    final a = double.tryParse(_aController.text);
    final b = double.tryParse(_bController.text);
    final c = double.tryParse(_cController.text);

    if (a == null || b == null || c == null) {
      context.read<RootsCubit>().emit(
        RootsErrorState(errorMessage: 'Введите корректные числовые значения'),
      );
      return;
    }

    // Проверка согласия
    if (!_isAgreed) {
      context.read<RootsCubit>().emit(
        RootsErrorState(
          errorMessage: 'Необходимо согласие на обработку данных',
        ),
      );
      return;
    }

    // Вычисление корней
    context.read<RootsCubit>().calculateRoots(a, b, c);
  }
}
