import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'ExcelClass.dart';

class DatabaseHelper {
  static Database? _database;
  static const String TABLE_NAME = 'excel_data';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'your_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first INTEGER,
            second INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertExcelData(List<ExcelData> dataList) async {
    final db = await database;
    for (var data in dataList) {
      await db.insert(TABLE_NAME, data.toMap());
    }
  }

  Future<List<ExcelData>> getAllExcelData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return ExcelData(
        maps[i]['first'],
        maps[i]['second'],
      );
    });
  }
}
