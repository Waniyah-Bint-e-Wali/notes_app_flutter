import 'package:flutter/material.dart';
import 'package:notes_app_flutter/Database_service.dart';
import 'package:notes_app_flutter/note.dart';

class NotesProvider extends ChangeNotifier{
  List<Note> _notes =[];
  List<Note> get notes => _notes;

  final DatabaseService _databaseService = DatabaseService.instance;

  Future<void> getAllNotes() async{
    _notes = await _databaseService.getnotes();
    notifyListeners();
  }

  Future<void> addNote(Note notes) async{
    await _databaseService.addnotes(notes);
    _notes.add(notes);
    notifyListeners();
  }

  Future<void> deleteNote(Note notes) async{
    await _databaseService.deletenotes(notes);
    _notes.remove(notes);
    notifyListeners();
  }

  Future<void> updateNote(Note notes) async{
    await _databaseService.updatenotes(notes);
    final index = _notes.indexWhere((element) => element.id == notes.id);
    _notes[index] = notes;
    notifyListeners();
  }

}