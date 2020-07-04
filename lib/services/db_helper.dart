/*import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cdli_tablet_app/services/data.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String dataTable = 'dataTable';
  String colId = 'id';
  String colDateDB = 'dateDB';
  String colThumbnailUrlDB = 'thumbnailUrlDB';
  String colUrlDB = 'urlDB';
  String colBlurbTitleDB = 'blurbTitleDB';
  String colThemeDB = 'themeDB';
  String colBlurbDB = 'blurbDB';
  String colFullTitleDB = 'fullTitleDB';
  String colFullInfoDB = 'fullInfoDB';

  DatabaseHelper._createInstance(); // Constructor

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // Executed only once
    }

    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Directory path for Android and iOS to store the database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'data.db';

    // Create the database at a given path
    var dataDatabase = await openDatabase(path, version: 1, onCreate: _createDB);
    return dataDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $dataTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colDateDB TEXT,'
        '$colThumbnailUrlDB TEXT, $colUrlDB TEXT, $colBlurbTitleDB TEXT, $colThemeDB TEXT, $colBlurbDB TEXT,'
        '$colFullTitleDB TEXT, $colFullInfoDB TEXT)');
  }

  // Fetch: Get all objects from the database
  Future<List<Map<String, dynamic>>> getDataMapList() async {

    Database db = await this.database;

    var result = await db.query(dataTable);

    return result;
  }

  // Insert: Insert an object into the database
  Future<int> insertData(Data data) async {

    var db = await this.database;

    var result = await db.insert(dataTable, data.toMap());

    return result;
  }

  // Delete: Delete an object from the database
  Future<int> deleteData(int id) async {

    var db = await this.database;

    var result = await db.rawDelete('DELETE FROM $dataTable WHERE $colId = $id');

    return result;
  }

  // Fetch: Get the number of objects in the database
  Future<int> getCount() async {

    var db = await this.database;

    List<Map<String, dynamic>> cnt = await db.rawQuery('SELECT COUNT (*) FROM $dataTable');

    int result = Sqflite.firstIntValue(cnt);

    return result;
  }

  // Get the Map list and convert it to object list
  Future<List<Data>> getDataList() async {

    var dataMapList = await getDataMapList();

    List<Data> dataList = List<Data>();
    // Create Data list from Map list
    for (var i = 0; i < dataMapList.length; i++) {
      dataList.add(Data.fromMapObject(dataMapList[i]));
    }

    return dataList;
  }
}*/