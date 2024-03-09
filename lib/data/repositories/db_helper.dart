import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unsplash_image/models/image_model/image_model.dart';

class DBHelper {
  static const _databaseName = 'image.db';
  static const _databaseVersion = 1;

  DBHelper._();
  static final DBHelper instance = DBHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE images(
        id TEXT PRIMARY KEY,
        description TEXT,
        raw TEXT,
        full TEXT,
        regular TEXT,
        small TEXT
      )
    ''');
  }

  Future<void> insertImage(ImageModel image) async {
    final db = await database;
    await db.insert(
      'images',
      image.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ImageModel>> getImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');
    return List.generate(maps.length, (i) {
      return ImageModel(
        id: maps[i]['id'],
        description: maps[i]['description'],
        raw: maps[i]['raw'],
        full: maps[i]['full'],
        regular: maps[i]['regular'],
        small: maps[i]['small'],
      );
    });
  }
}
