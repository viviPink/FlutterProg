import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    super.key,
    required this.a,
    required this.b,
    required this.c,
    required this.roots,
  });
  final double a;
  final double b;
  final double c;
  final List<String> roots;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Результаты для уравнения:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('${a}x² + ${b}x + ${c} = 0'),
        SizedBox(height: 10),
        ...roots.map((root) => Text(root)).toList(),
      ],
    );
  }
}
