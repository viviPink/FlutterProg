import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart'; 

class StorageService {
  static const String weatherHistoryKey = 'weather_history';

  /// Сохраняет новый в историю
  Future<void> saveWeather(WeatherData weather) async {
    final prefs = await SharedPreferences.getInstance();
    final List<WeatherData> history = await getWeatherHistory();

    // Добавляем новую запись в начало
    history.insert(0, weather);

    // Ограничиваем количество записей
    if (history.length > 20) {
      history.removeLast();
    }

    // Преобразуем в список JSON-строк
    final encodedList = history.map((data) => jsonEncode(data.toJson())).toList();

    // Сохраняем в SharedPreferences
    await prefs.setStringList(weatherHistoryKey, encodedList);
  }

  /// Получает всю историю из SharedPreferences
  Future<List<WeatherData>> getWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList(weatherHistoryKey) ?? [];

    return encodedList
        .map((jsonString) => WeatherData.fromJson(jsonDecode(jsonString)))
        .toList();
  }
}