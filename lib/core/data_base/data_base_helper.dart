import 'package:sqflite/sqflite.dart';

import '../../models/nodes/node.dart';

class DatabaseHelper {
  ///////// data base object create
  Database? _database;

  ///////// this getter function for data base
  Future<Database?> get database async {
    ///////// check data base already initialize
    ///  if data base initialize return data base
    if (_database != null) return _database;
    /////// data base not initialize
    /// call data base initialize function
    _database = await initDatabase();
    /////// return data base
    return _database;
  }

  //////////// data base initialize function
  Future<Database> initDatabase() async {
    ////////////  data base name notes.db
    ///////////   if data base dos't exist create function call
    return await openDatabase('notes.db', version: 1, onCreate: _createDb);
  }

  /////////////// data base create Function
  Future _createDb(Database db, int version) async {
    /////////// id is primary key and auto increment
    ///  title & mobile number container
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        mobileNumber TEXT
      )
    ''');
  }

  // CRUD operations

  //////////  new data insert data base function
  static Future<int> insertNote(Note note) async {
    /////// data base object create
    final db = await DatabaseHelper().database;
    /////// data insert
    return await db!.insert('notes', note.toMap());
  }

////////// all notes get form data base
  static Future<List<Note>> getNotes() async {
    /////// data base object create
    final db = await DatabaseHelper().database;
    ///////// get data form data base using query operation
    final List<Map<String, dynamic>> maps = await db!.query('notes');
    ///////// data convert & return
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

//////////// data update function create
  static Future<int> updateNote(Note note) async {
    /////// data base object create
    final db = await DatabaseHelper().database;
    /////// data update
    return await db!
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  ///////// data remove or delete function  create
  static Future<int> deleteNote(int id) async {
    /////// data base object create
    final db = await DatabaseHelper().database;
    ///// data delete query call
    return await db!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
