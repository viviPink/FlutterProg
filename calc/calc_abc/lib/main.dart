import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/first_screen.dart';
import 'screens/cubit/screen_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Убираем баннер "Debug"
        title: 'Квадратное уравнение',
        home: FirstScreen(), 
      ),
    );
  }
}