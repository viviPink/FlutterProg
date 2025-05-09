import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab7/services/storage_services.dart';
import 'package:lab7/services/weather_services.dart';
import '../cubits/weather_cubit.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WeatherCubit(
        WeatherService(),   // Передаём  погоду
        StorageService(),   // Передаём  хранилище
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}