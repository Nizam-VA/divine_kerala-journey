import 'package:devine_kerala_journey/model/user_story.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabaseHelper {
  static const _dbVersion = 1;

  static const table = 'user_story';

  static const columnId = '_id';
  static const columnPlace = 'place';
  static const columnDescription = 'description';
  static const columnCategory = 'category';
  static const columnImage = 'image';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase('user_story.db',
        version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnPlace TEXT NOT NULL,
      $columnDescription TEXT NOT NULL,
      $columnCategory TEXT NOT NULL,
      $columnImage TEXT NOT NULL)
      ''');
  }

  Future<int> insertStory(UserStory userStory) async {
    final db = await database;
    return await db.insert(
      table,
      {
        columnPlace: userStory.place,
        columnDescription: userStory.description,
        columnCategory: userStory.category,
        columnImage: userStory.images,
      },
    );
  }

  Future<List<UserStory>> getStories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(
      maps.length,
      (index) => UserStory(
        id: maps[index][columnId],
        place: maps[index][columnPlace],
        description: maps[index][columnDescription],
        category: maps[index][columnCategory],
        images: maps[index][columnImage],
      ),
    );
  }

  Future<int> updateStory(UserStory userStory) async {
    final db = await database;
    return await db.update(
      table,
      {
        columnPlace: userStory.place,
        columnDescription: userStory.description,
        columnCategory: userStory.category,
        columnImage: userStory.images,
      },
      where: '$columnId = ?',
      whereArgs: [userStory.id],
    );
  }

  Future<int> deleteStory(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
