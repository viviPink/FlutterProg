import 'package:flutter/material.dart';
import 'package:lab7/models/weather_model.dart';
import 'package:lab7/services/heat_index_calculator.dart';
import 'package:url_launcher/url_launcher.dart';

// Экран для расчёта индекса жары
class CalculationsScreen extends StatefulWidget {
  final WeatherData? initialWeather;

  const CalculationsScreen({Key? key, this.initialWeather}) : super(key: key);

  @override
  State<CalculationsScreen> createState() => _CalculationsScreenState();
}

class _CalculationsScreenState extends State<CalculationsScreen> {
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();


// калькулятор
  late final HeatIndexCalculator _calculator; 
  double _heatIndex = 0.0;
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _calculator = HeatIndexCalculator(); 
    _loadHistory(); // загружаем все данные прошлых вычислений

    if (widget.initialWeather != null) {
      final weather = widget.initialWeather!;
      _tempController.text = weather.temperature.toString(); // Наполняем поля данными
      _humidityController.text = weather.humidity.toString();
      _calculateAndSaveHeatIndex(weather.temperature, weather.humidity); 
    }
  }

  Future<void> _loadHistory() async {
    final loadedHistory = await _calculator.loadHistory(); 
    setState(() {
      _history = loadedHistory; // Храним память в переменной
    });
  }

  // Основная функция для вычислений и загрузки 
  void _calculateAndSaveHeatIndex(double temperature, double humidity) {
    final hiFahrenheit = _calculator.calculateHeatIndex(temperature, humidity);
    final hiCelsius = _calculator.fahrenheitToCelsius(hiFahrenheit);

    setState(() {
      _heatIndex = hiCelsius; // Передача результата
    });
    // 1 знак после запятой
    final formattedTemp = temperature.toStringAsFixed(1);
    final formattedHumidity = humidity.toStringAsFixed(1);
    final formattedHi = hiCelsius.toStringAsFixed(1);

    final entry = 'Температура: $formattedTemp°C, Влажность: $formattedHumidity%, Ощущается как: $formattedHi°C';
    _calculator.saveHistory(entry).then((_) => _loadHistory()); // Добавляем запись 
  }


  // Функция для открытия ссылки
  void _launchUrl(BuildContext context) async {
    final url = Uri.parse('https://06.mchs.gov.ru/deyatelnost/press-centr/novosti/4517372');
    
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть ссылку')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Расчет индекса жары')), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              decoration: const InputDecoration(labelText: 'Температура (°C)'), 
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _humidityController,
              decoration: const InputDecoration(labelText: 'Влажность (%)'), 
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final temp = double.tryParse(_tempController.text);
                final humidity = double.tryParse(_humidityController.text);
                if (temp != null && humidity != null) {
                  _calculateAndSaveHeatIndex(temp, humidity);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('введите числовые значения')), 
                  );
                }
              },
              child: const Text('Рассчитать'), 
            ),
            const SizedBox(height: 16),
            Text(
              'Ощущаемая температура: ${_heatIndex.toStringAsFixed(1)}°C', 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('История вычислений', style: TextStyle(fontSize: 20)), 
            Expanded(
              child: _history.isEmpty
                  ? const Center(child: Text('Нет данных')) 
                  : ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(_history[index])); 
                      },
                    ),
            ),
             // Кнопка для открытия рекомендаций
            ElevatedButton.icon(
              onPressed: () => _launchUrl(context),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Открыть рекомендации в жару'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 219, 101, 223),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}