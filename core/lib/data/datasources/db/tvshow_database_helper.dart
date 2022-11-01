import 'dart:async';

import 'package:core/data/models/tvshow/tvshow_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTvshow {
  static DatabaseHelperTvshow? _databaseHelperTvshow;
  DatabaseHelperTvshow._instance() {
    _databaseHelperTvshow = this;
  }

  factory DatabaseHelperTvshow() =>
      _databaseHelperTvshow ?? DatabaseHelperTvshow._instance();

  static Database? _databaseTvshow;

  Future<Database?> get database async {
    if (_databaseTvshow == null) {
      _databaseTvshow = await _initDb();
    }
    return _databaseTvshow;
  }

  static const String _tblWatchlistTvshow = 'watchlistTvshow';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditontonTvshow.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlistTvshow (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlistTvshow(TvshowTable tvshow) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvshow, tvshow.toJson());
  }

  Future<int> removeWatchlistTvshow(TvshowTable tvshow) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvshow,
      where: 'id = ?',
      whereArgs: [tvshow.id],
    );
  }

  Future<Map<String, dynamic>?> getTvshowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvshow,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvshows() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvshow);

    return results;
  }
}
