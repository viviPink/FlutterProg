// Базовый класс состояния
abstract class HistoryState {}

// Начальное состояние
class HistoryInitial extends HistoryState {}

// Состояние загрузки
class HistoryLoading extends HistoryState {}

// Состояние успешной загрузки данных
class HistoryLoaded extends HistoryState {
  final List<Map<String, dynamic>> calculations;

  HistoryLoaded(this.calculations);
}

// Состояние ошибки
class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}