import 'package:calc_abc/database.dart';
import 'package:calc_abc/screens/cubit/data_cubit/history_data_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  // Загрузка всех расчетов из базы данных
  Future<void> loadCalculations() async {
    emit(HistoryLoading());
    try {
      final calculations = await DatabaseProvider.db.getAllCalculations();
      emit(HistoryLoaded(calculations));
    } catch (e) {
      emit(HistoryError('Ошибка загрузки данных: $e'));
    }
  }

  // Добавление нового расчета в базу данных
  Future<void> addCalculation(Map<String, dynamic> calculation) async {
    try {
      await DatabaseProvider.db.addCalculation(calculation);
      loadCalculations(); // Перезагружаем данные
    } catch (e) {
      emit(HistoryError('Ошибка добавления расчета: $e'));
    }
  }

  // Удаление расчета из базы данных
  Future<void> deleteCalculation(int id) async {
    try {
      await DatabaseProvider.db.deleteCalculation(id);
      loadCalculations(); 
    } catch (e) {
      emit(HistoryError('Ошибка удаления расчета: $e'));
    }
  }

  // Очистка всех расчетов из базы данных
  Future<void> clearAllCalculations() async {
    try {
      await DatabaseProvider.db.clearAllCalculations();
      loadCalculations(); 
    } catch (e) {
      emit(HistoryError('Ошибка очистки данных: $e'));
    }
  }
}