

// второй экран на котором показывается результат вычислений
import 'package:flutter/material.dart';
import 'dart:math';

//передаем значения
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
            Text('${a}x² + ${b}x + $c = 0'),
            SizedBox(height: 20),
            for (String root in calculateRoots()) Text(root),
          ],
        ),
      ),
    );
  }
}