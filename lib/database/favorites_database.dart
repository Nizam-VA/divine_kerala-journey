import 'package:devine_kerala_journey/model/favorites.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFavorites {
  static const _dbVersion = 1;

  static const table = 'favorites';

  static const columnId = '_id';
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
  $columnPlace TEXT NOT NULL,
  $columnImage TEXT NOT NULL)
''');
  }

  Future<int> insertFavorites(Favorites favorite) async {
    final db = await database;
    return await db.insert(
      table,
      {columnPlace: favorite.place, columnImage: favorite.image},
    );
  }

  Future<List<Favorites>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(
      maps.length,
      (index) => Favorites(
          id: maps[index][columnId],
          place: maps[index][columnPlace],
          image: maps[index][columnImage]),
    );
  }

  Future<int> deleteFavorite(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
