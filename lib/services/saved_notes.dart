import 'package:flutter/material.dart';
import 'package:notes_app/services/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedNotes {

  static Database database;

  Future<Database> get mydatabase async {
    if (database != null)
      return database;

    database = await initDB();
    return database;
  }


  static Future<String> dbPath() async {
    return await getDatabasesPath();
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    //print(await dbPath());
    final Future<Database> database = openDatabase(
        join(await dbPath(), 'notes.db'), onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title BLOB, content BLOB)");
    }, version: 1);

    return database;
  }

  Future<void> insertNote(Note note) async {
    final Database db = await mydatabase;

    //print("while inserting - ${note.toMap()['title']}");

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> retrieveAllNotes() async {
    // Get a reference to the database.
    final Database db = await mydatabase;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // Convert the List<Map<String, dynamic> into a List<Note>.
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
      );
    });

  }

  deleteNote(int id) async {
    await database.delete('notes', where: 'id = $id');
  }
}