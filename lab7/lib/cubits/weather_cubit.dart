import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab7/services/storage_services.dart';
import 'package:lab7/models/weather_model.dart';
import 'package:lab7/services/weather_services.dart';
import 'weather_state.dart'; 

// это помогает мне:
// Получать данные о погоде
// Сохранять их
// Загружать историю
// Управлять состоянием экрана


// Запрашивает данные о погоде у weatherService
// Сохраняет эти данные в историю через storageService
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  final StorageService storageService;

  WeatherCubit(this.weatherService, this.storageService)
      : super(WeatherInitial());

  Future<void> getWeather(String stationId) async {
    emit(WeatherLoading());
    try {
      final WeatherData weather = await weatherService.fetchWeather(stationId);
      await storageService.saveWeather(weather);

      final List<WeatherData> history = await storageService.getWeatherHistory();
      emit(WeatherLoaded(currentWeather: weather, history: history));
    } catch (e) {
      emit(WeatherError('Ошибка при загрузке погоды:( $e'));
    }
  }

// Загружает только историю погоды , без нового запроса к API
  Future<void> loadHistory() async {
    emit(WeatherLoading());
    try {
      final List<WeatherData> history = await storageService.getWeatherHistory();
      emit(WeatherLoaded(currentWeather: null, history: history));
    } catch (e) {
      emit(WeatherError('Ошибка при загрузке истории:( $e'));
    }
  }
}