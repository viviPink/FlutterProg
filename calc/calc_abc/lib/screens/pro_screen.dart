import 'package:calc_abc/screens/cubit/screev_state.dart';
import 'package:calc_abc/screens/widjets/form_input.dart';
import 'package:calc_abc/screens/widjets/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/screen_cubit.dart';

class QuadraticEquationScreen extends StatefulWidget {
  @override
  _QuadraticEquationScreenState createState() =>
      _QuadraticEquationScreenState();
}

class _QuadraticEquationScreenState extends State<QuadraticEquationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор квадратных уравнений')),
      body: BlocProvider(
        create: (context) => RootsCubit(),
        child: BlocBuilder<RootsCubit, RootsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // обращаемся к виджетам для ввода данных
                  if (state is InitialRootsState) FormInput(),
                  // Отображение результатов или ошибок
                  if (state is RootsCalculatedState)
                    // обращаемся к виджетам для вывода результатат
                    ResultWidget(
                      a: state.a,
                      b: state.b,
                      c: state.c,
                      roots: state.roots,
                    ),
                  if (state is RootsErrorState)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        state.errorMessage,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
