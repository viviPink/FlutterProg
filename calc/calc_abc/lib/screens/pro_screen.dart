import 'package:calc_abc/screens/cubit/data_cubit/history_data_cubit.dart';
import 'package:calc_abc/screens/cubit/sreens_cubit/screev_state.dart';
import 'package:calc_abc/screens/widjets/form_input.dart';
import 'package:calc_abc/screens/widjets/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/sreens_cubit/screen_cubit.dart';
import 'history_screen.dart'; // Импортируем экран истории


class QuadraticEquationScreen extends StatefulWidget {
  @override
  _QuadraticEquationScreenState createState() =>
      _QuadraticEquationScreenState();
}

class _QuadraticEquationScreenState extends State<QuadraticEquationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор квадратных уравнений'),
        actions: [
          IconButton(
            // иконка историии 
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => HistoryCubit()..loadCalculations(),
                    child: HistoryScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => RootsCubit(),
        child: BlocListener<RootsCubit, RootsState>(
          listener: (context, state) {
            if (state is RootsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
          child: BlocBuilder<RootsCubit, RootsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Виджет для ввода данных с валидацией
                    if (state is InitialRootsState || state is RootsErrorState)
                      FormInput(
                        onCalculate: (a, b, c) {
                          context.read<RootsCubit>().calculateRoots(a, b, c);
                        },
                      ),
                    // Отображение результатов
                    if (state is RootsCalculatedState)
                      ResultWidget(
                        a: state.a,
                        b: state.b,
                        c: state.c,
                        roots: state.roots,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}