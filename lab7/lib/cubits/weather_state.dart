


import 'package:lab7/models/weather_model.dart';


abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherData? currentWeather;
  final List<WeatherData> history;

  WeatherLoaded({required this.currentWeather, required this.history});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}