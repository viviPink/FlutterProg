// Абстрактное состояние для кубита
abstract class RootsState {}

// Начальное состояние (инициализация)
class InitialRootsState extends RootsState {}

// Состояние для успешного вычисления корней
class RootsCalculatedState extends RootsState {
  final double a, b, c; // Коэффициенты уравнения
  final List<String> roots; // Результаты вычислений

  RootsCalculatedState({
    required this.a,
    required this.b,
    required this.c,
    required this.roots,
  });
}

// Состояние для ошибок
class RootsErrorState extends RootsState {
  final String errorMessage; // Сообщение об ошибке

  RootsErrorState({required this.errorMessage});
}