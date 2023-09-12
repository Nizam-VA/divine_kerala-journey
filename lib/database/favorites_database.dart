import 'package:devine_kerala_journey/model/pilgrimages_data.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<String>> favoriteNotifier = ValueNotifier<List<String>>([]);
ValueNotifier<List<PilgrimagesData>> pilgrimNotifier =
    ValueNotifier<List<PilgrimagesData>>([]);

class DatabaseFavorites {
  static const _dbVersion = 1;

  static const table = 'favorites';

  static const columnId = '_id';
  static const columnPlaceId = 'placeId';
  static const columnPlace = 'place';
  static const columnImage = 'image';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase('favorites.db',
        version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $table (
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnPlaceId TEXT NOT NULL)
''');
  }

  insertFavorites(PilgrimagesData pilgrim) async {
    final db = await database;
    await db.insert(
      table,
      {
        columnPlaceId: pilgrim.id,
      },
    );
    favoriteNotifier.value.add(pilgrim.id);
    pilgrimNotifier.value.add(pilgrim);
    pilgrimNotifier.notifyListeners();
    favoriteNotifier.notifyListeners();
  }

  isFavorite() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM $table',
    );
    for (var map in result) {
      favoriteNotifier.value.add(map[columnPlaceId] as String);
    }
  }

  deleteFavorite(String id) async {
    final db = await database;
    await db.delete(
      table,
      where: '$columnPlaceId = ?',
      whereArgs: [id],
    );
    favoriteNotifier.value.removeWhere((element) => element == id);
    pilgrimNotifier.value.removeWhere((element) => element.id == id);
    pilgrimNotifier.notifyListeners();
    favoriteNotifier.notifyListeners();
  }
}
