import 'package:calc_abc/screens/cubit/screen_cubit.dart';
import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final Function(double a, double b, double c) onCalculate;

  const FormInput({super.key, required this.onCalculate});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  bool _isAgreed = false;
  String? _aError;
  String? _bError;
  String? _cError;

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
            errorText: _aError,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _validateInputs(),
        ),
        TextField(
          controller: _bController,
          decoration: InputDecoration(
            labelText: 'Коэффициент b (x)',
            errorText: _bError,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _validateInputs(),
        ),
        TextField(
          controller: _cController,
          decoration: InputDecoration(
            labelText: 'Коэффициент c',
            errorText: _cError,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => _validateInputs(),
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
            Text(
              'Согласен на обработку данных',
              style: TextStyle(
                //если не согласен то красенький
                color: _isAgreed ? Colors.black : Colors.red,
              ),
            ),
          ],
        ),

        // Кнопка расчета
        ElevatedButton(
          onPressed: _validateAndCalculate,
          child: Text('Вычислить корни'),
        ),
      ],
    );
  }

  void _validateInputs() {
    setState(() {
      _aError = _validateCoefficient(_aController.text, 'a');
      _bError = _validateCoefficient(_bController.text, 'b');
      _cError = _validateCoefficient(_cController.text, 'c');
    });
  }

  String? _validateCoefficient(String value, String coefficientName) {
    if (value.isEmpty) return 'Введите коэффициент $coefficientName';
    
    final numValue = double.tryParse(value);
    if (numValue == null) return 'Введите число';
    
    if (coefficientName == 'a' && numValue == 0) {
      return 'Коэффициент a не может быть равен 0';
    }
    
    return null;
  }

  void _validateAndCalculate() {
    _validateInputs();

    if (_aError != null || _bError != null || _cError != null) {
      return;
    }

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Необходимо согласие на обработку данных')
        ),
      );
      return;
    }

    final a = double.parse(_aController.text);
    final b = double.parse(_bController.text);
    final c = double.parse(_cController.text);

    widget.onCalculate(a, b, c);
  }
}