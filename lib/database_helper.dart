import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ingreso.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('empleados.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE empleados(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        anio INTEGER NOT NULL,
        salario REAL NOT NULL
      )
    ''');
  }

  Future<int> createEmpleado(Ingreso empleado) async {
    final db = await instance.database;
    return await db.insert('empleados', empleado.toMap());
  }

  Future<List<Ingreso>> getAllEmpleados() async {
    final db = await instance.database;
    final result = await db.query('empleados', orderBy: 'nombre ASC');
    return result.map((json) => Ingreso.fromMap(json)).toList();
  }

  Future<int> updateEmpleado(Ingreso empleado) async {
    final db = await instance.database;
    return await db.update(
      'empleados',
      empleado.toMap(),
      where: 'id = ?',
      whereArgs: [empleado.id],
    );
  }

  Future<int> deleteEmpleado(int id) async {
    final db = await instance.database;
    return await db.delete(
      'empleados',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<double> getSalarioPromedio() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT AVG(salario) as promedio FROM empleados');
    return result.first['promedio'] as double? ?? 0.0;
  }

  Future<int> getTotalEmpleados() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as total FROM empleados');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
