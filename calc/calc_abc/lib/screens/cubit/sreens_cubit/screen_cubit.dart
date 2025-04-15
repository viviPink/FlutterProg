import 'package:calc_abc/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screev_state.dart';
import 'dart:math';


class RootsCubit extends Cubit<RootsState> {
  RootsCubit() : super(InitialRootsState());

  void calculateRoots(double a, double b, double c) {
    if (a == 0) {
      emit(RootsErrorState(errorMessage: 'Коэффициент "a" не должен быть равен 0'));
      return;
    }

    try {
      double discriminant = b * b - 4 * a * c;
      List<String> roots = [];

      if (discriminant > 0) {
        double root1 = (-b + sqrt(discriminant)) / (2 * a);
        double root2 = (-b - sqrt(discriminant)) / (2 * a);
        roots = [
          'Два корня: ${root1.toStringAsFixed(2)} и ${root2.toStringAsFixed(2)}',
        ];
      } else if (discriminant == 0) {
        double root = -b / (2 * a);
        roots = ['Один корень: ${root.toStringAsFixed(2)}'];
      } else {
        roots = ['Нет корней'];
      }

      emit(RootsCalculatedState(a: a, b: b, c: c, roots: roots));

      // Сохраняем данные в базу данных
      saveToDatabase(a, b, c, roots.join(', '));
    } catch (e) {
      emit(RootsErrorState(errorMessage: 'Ошибка при вычислении корней: $e'));
    }
  }

 // Метод для сохранения данных расчета в базу данных
Future<void> saveToDatabase(double a, double b, double c, String roots) async {
    try {
      // Создаем объект (Map), который содержит данные для записи в базу данных:
      // - 'a', 'b', 'c': коэффициенты квадратного уравнения
      // - 'roots': строковое представление корней уравнения
      // - 'timestamp': временная метка, когда был выполнен расчет (текущее время в формате ISO 8601)
      final calculation = {
        'a': a,
        'b': b,
        'c': c,
        'roots': roots,
        'timestamp': DateTime.now().toIso8601String(), // Текущая дата и время в строковом формате
      };

      // Вызываем метод addCalculation из DatabaseProvider для добавления данных в базу данных
      await DatabaseProvider.db.addCalculation(calculation);
    } catch (e) {
      // Если возникает ошибка при записи в базу данных, выводим сообщение об ошибке в консоль
      print('Ошибка записи в базу данных: $e');
    }
  }

  // Метод для сброса состояния кубита в начальное состояние
  void resetCubit() {
    // Вызываем emit с состоянием InitialRootsState, чтобы вернуть кубит в исходное состояние
    emit(InitialRootsState());
  }
}