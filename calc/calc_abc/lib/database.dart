import 'dart:io'; // Импортируем библиотеку для работы с файловой системой
import 'package:sqflite/sqflite.dart'; // Импортируем библиотеку для работы с SQLite
import 'package:path_provider/path_provider.dart'; 

// Класс реализует паттерн Singleton для управления базой данных
class DatabaseProvider {
  // Приватный конструктор для создания единственного экземпляра класса
  DatabaseProvider._init();

  // Статический экземпляр класса для доступа к базе данных
  static final DatabaseProvider db = DatabaseProvider._init();

  // Переменная для хранения экземпляра базы данных
  static Database? _database;

  // Геттер для получения экземпляра базы данных
  Future<Database> get database async {
    if (_database != null) return _database!; // Если база данных уже создана, возвращаем её
    _database = await _initDB('quadratic_equations.db'); // Иначе инициализируем базу данных
    return _database!;
  }

  // Метод для инициализации базы данных
  Future<Database> _initDB(String filePath) async {
    Directory dir = await getApplicationDocumentsDirectory(); // Получаем путь к директории приложения
    String path = '${dir.path}/$filePath'; // Формируем полный путь к файлу базы данных
    // Открываем базу данных и создаём таблицу, если она ещё не существует
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Метод для создания таблицы в базе данных
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE QuadraticEquations (
        id INTEGER PRIMARY KEY AUTOINCREMENT, // Уникальный идентификатор записи
        a REAL NOT NULL, // Коэффициент A уравнения
        b REAL NOT NULL, // Коэффициент B уравнения
        c REAL NOT NULL, // Коэффициент C уравнения
        roots TEXT NOT NULL, // Корни уравнения (в виде строки)
        timestamp TEXT NOT NULL // Временная метка для записи
      )
    ''');
  }

  // Метод для добавления новой записи в таблицу
  Future<int> addCalculation(Map<String, dynamic> calculation) async {
    Database db = await database; // Получаем экземпляр базы данных
    return await db.insert('QuadraticEquations', calculation); // Вставляем данные в таблицу
  }

  // Метод для получения всех записей из таблицы
  Future<List<Map<String, dynamic>>> getAllCalculations() async {
    Database db = await database; // Получаем экземпляр базы данных
    return await db.query('QuadraticEquations', orderBy: 'timestamp DESC'); // Запрашиваем все записи, отсортированные по времени
  }

  // Метод для получения записи по её ID
  Future<List<Map<String, dynamic>>> getCalculationById(int id) async {
    Database db = await database; // Получаем экземпляр базы данных
    return await db.query(
      'QuadraticEquations',
      where: "id = ?", // Условие выборки по ID
      whereArgs: [id], // Параметры условия
    );
  }

  // Метод для удаления записи по её ID
  Future<int> deleteCalculation(int id) async {
    Database db = await database; // Получаем экземпляр базы данных
    return await db.delete(
      "QuadraticEquations",
      where: "id = ?", // Условие удаления по ID
      whereArgs: [id], // Параметры условия
    );
  }

  // Метод для обновления записи в таблице
  Future<int> updateCalculation(Map<String, dynamic> calculation, int id) async {
    Database db = await database; // Получаем экземпляр базы данных
    return await db.update(
      "QuadraticEquations", // Название таблицы
      calculation, // Новые данные для записи
      where: "id = ?", // Условие обновления по ID
      whereArgs: [id], // Параметры условия
    );
  }

  // Метод для очистки всех записей из таблицы
  Future<void> clearAllCalculations() async {
    Database db = await database; // Получаем экземпляр базы данных
    await db.delete("QuadraticEquations"); // Удаляем все записи из таблицы
  }

  // Метод для закрытия соединения с базой данных
  Future<void> close() async {
    final db = await database; // Получаем экземпляр базы данных
    db.close(); // Закрываем соединение
  }
}