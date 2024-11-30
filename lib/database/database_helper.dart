import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('news.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE news (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image TEXT,
        source TEXT,
        datetime TEXT,
        headline TEXT,
        url TEXT
      )
    ''');
  }

  Future<void> insertNews(List<NewsModel> newsList) async {
    final db = await database;

    for (var news in newsList) {
      await db.insert('news', news.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<NewsModel>> fetchCachedNews() async {
    final db = await database;
    final result = await db.query('news');
    return result.map((json) => NewsModel.fromJson(json)).toList();
  }
}
