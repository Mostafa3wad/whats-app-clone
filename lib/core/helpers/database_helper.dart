import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const int _databaseVersion = 1;
  final Logger logger = Logger();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'database_name'),
      version: _databaseVersion,
      onCreate: _onCreate,
      onDowngrade: _onDowngrade,
      onOpen: _onOpen,
    );
  }

  Future<void> _onCreate(Database db, int version) async {}

  Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS Table_Name');

    await _onCreate(db, newVersion);
  }

  Future<void> _onOpen(Database db) async {
    logger.i('database_name OPENED');
  }

  Future<int> insert({
    required String tableName,
    required Map<String, dynamic> row,
  }) async {
    final Database db = await database;
    return await db.insert(
      tableName,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertRow({
    required String tableName,
    required List<Map<String, dynamic>> row,
  }) async {
    final Database db = await database;
    return await db.rawInsert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final Database db = await database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> querySingleRow({
    required String tableName,
    required String where,
    required List<Object?>? whereArgs,
  }) async {
    final Database db = await database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  Future<int> queryRowCount({required String tableName}) async {
    final Database db = await database;
    final List<Map<String, Object?>> results = await db.rawQuery(
      'SELECT COUNT(*) FROM $tableName',
    );
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update({
    required String tableName,
    required Map<String, dynamic> row,
    required String where,
    required List<Object?>? whereArgs,
  }) async {
    final Database db = await database;
    return await db.update(
      tableName,
      row,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete({
    required String tableName,
    required String? where,
    required List<Object?>? whereArgs,
  }) async {
    final Database db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }
}
