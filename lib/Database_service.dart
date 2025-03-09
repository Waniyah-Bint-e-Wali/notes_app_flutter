import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notes_app_flutter/note.dart';
import 'package:notes_app_flutter/home_screen.dart';

class DatabaseService{
  static Database? _db;
  static final DatabaseService instance= DatabaseService._constructor();
  //Creating instance of class
  DatabaseService._constructor();
  //Creating variables for table names
  final String _table = "Notes_Table";
  final String _id = "id";
  final String _title = "Title";
  final String _description ="Description";

  Future<Database> get database async {
    if(_db!=null){
      return _db!;
    }
    _db=await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async{
    final getpath = await getDatabasesPath();
    final databasepath = join(getpath , "my_database.db");
    final database = await openDatabase(
      databasepath,
      version:1,
      onCreate: (db,version){
        db.execute(
            '''CREATE TABLE  $_table( $_id INTEGER PRIMARY KEY , $_title TEXT , $_description TEXT)'''
        );
      },
    );
    return database;
  }
  Future<int> addnotes(Note notes) async {
    final db = await database;
    int id = await db.insert(
      _table,
      {
        _title: notes.title,
        _description: notes.description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Note>> getnotes() async {
    final db = await database;
    final data = await db.query(_table);

    return data.map((item) => Note(
      item[_id] as int,
      item[_title] as String,
      item[_description] as String,
    )).toList();
  }

  Future <void> deletenotes(Note notes) async{
    final db= await database;
    await db.delete(
    _table,
      where:'$_id=?',
      whereArgs:[notes.id],
    );
  }
  Future <void> updatenotes(Note notes)async{
    final db= await database;
    await db.update(
      _table, {_title:notes.title , _description:notes.description},
      where:'$_id =?',
      whereArgs:[notes.id],
    );
  }


}