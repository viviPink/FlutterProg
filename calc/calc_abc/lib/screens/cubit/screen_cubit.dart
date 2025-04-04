import 'package:flutter_bloc/flutter_bloc.dart';
import 'screev_state.dart'; 
import 'dart:math';

// Кубит для вычисления корней квадратного уравнения
class RootsCubit extends Cubit<RootsState> {
  // Устанавливает начальное состояние
  RootsCubit() : super(InitialRootsState());

  // Метод для вычисления корней квадратного уравнения
  void calculateRoots(double a, double b, double c) {
    // Проверка на некорректные входные данные
    if (a == 0) {
      emit(RootsErrorState(errorMessage: 'Коэффициент "a" не должен быть равен 0'));
      return;
    }

    try {
      // Вычисление дискриминанта
      double discriminant = b * b - 4 * a * c;

      // Создание списка для хранения результатов
      List<String> roots = [];

      // Анализ дискриминанта
      if (discriminant > 0) {
        double root1 = (-b + sqrt(discriminant)) / (2 * a);
        double root2 = (-b - sqrt(discriminant)) / (2 * a);
        roots = ['Два корня: ${root1.toStringAsFixed(2)} и ${root2.toStringAsFixed(2)}'];
      } else if (discriminant == 0) {
        double root = -b / (2 * a);
        roots = ['Один корень: ${root.toStringAsFixed(2)}'];
      } else {
        roots = ['Нет корней'];
      }

      // Переход в состояние успешного вычисления
      emit(
        RootsCalculatedState(
          a: a,
          b: b,
          c: c,
          roots: roots,
        ),
      );
    } catch (e) {
      // Переход в состояние ошибки при возникновении исключения
      emit(RootsErrorState(errorMessage: 'Ошибка при вычислении корней: $e'));
    }
  }
}