import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

// погода с сайта openweathermap
class WeatherService {
  final String apiKey = 'be888a7ec9a91996d435ace015ee43de'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData(
        city: data['name'],
        temperature: data['main']['temp'].toDouble(),
        humidity: data['main']['humidity'].toDouble(),
        windSpeed: data['wind']['speed'].toDouble(),
        description: data['weather'][0]['description'],
        timestamp: DateTime.now(),
      );
    } else {
      throw Exception('ошибка в загрузке данных о погоде апи ломаться я грустить');
    }
  }
}