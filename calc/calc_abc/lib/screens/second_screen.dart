import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/screen_cubit.dart'; 
import 'cubit/screev_state.dart'; 

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты'),
      ),
      body: Center(
        child: BlocBuilder<RootsCubit, RootsState>(
          builder: (context, state) {
            if (state is RootsCalculatedState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Уравнение:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildFormula(state.a, state.b, state.c),
                    SizedBox(height: 20),
                    Text(
                      'Результаты:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ...state.roots.map((root) => Text(root, style: TextStyle(fontSize: 18))),
                  ],
                ),
              );
            } else if (state is RootsErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  // Метод для красивого отображения формулы
  Widget _buildFormula(double a, double b, double c) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20, color: Colors.black),
        children: [
          TextSpan(text: '${a.toStringAsFixed(1)}x² '),
          if (b >= 0) TextSpan(text: '+ ${b.toStringAsFixed(1)}x ') else TextSpan(text: '- ${(-b).toStringAsFixed(1)}x '),
          if (c >= 0) TextSpan(text: '+ ${c.toStringAsFixed(1)} ') else TextSpan(text: '- ${(-c).toStringAsFixed(1)} '),
          TextSpan(text: '= 0'),
        ],
      ),
    );
  }
}