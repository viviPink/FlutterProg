

import 'package:shared_preferences/shared_preferences.dart';

class HeatIndexCalculator {
  // Переводим градусы Цельсия в Фаренгейты (формула)
  double _celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;

  // Переводим градусы Фаренгейта обратно в Цельсии (для загрузки данных)
  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  // Расчёт индекса жары по формуле 
  double calculateHeatIndex(double tempC, double humidity) {
    double tempF = _celsiusToFahrenheit(tempC);
    return -42.379 +
        (2.04901523 * tempF) +
        (10.14333127 * humidity) -
        (0.22475541 * tempF * humidity) -
        (6.83783e-3 * tempF * tempF) -
        (5.481717e-2 * humidity * humidity) +
        (1.22874e-3 * tempF * tempF * humidity) +
        (8.5282e-4 * tempF * humidity * humidity) -
        (1.99e-6 * tempF * tempF * humidity * humidity);
  }

  // Сохранение истории вычислений
  Future<void> saveHistory(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('heat_index_history') ?? [];

    history.insert(0, entry);

    if (history.length > 10) {
      history.removeLast(); // Ограничиваем до 10 записей 
    }

    await prefs.setStringList('heat_index_history', history);
  }

  // Загрузка истории из SharedPreferences
  Future<List<String>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('heat_index_history') ?? [];
  }
}