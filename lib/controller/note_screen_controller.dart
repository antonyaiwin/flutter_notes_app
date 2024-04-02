import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/core/constants/color_constants.dart';
import 'package:notes_app/model/note_model.dart';

class NotesScreenController {
  static List<dynamic> notesKeyList = [];
  static var box = Hive.box('notesBox');

  static Future<void> addNote({required NoteModel item}) async {
    // notesList.add(item);
    await box.add(item.toMap());
    refreshNoteKeyList();
  }

  static Future<void> deleteNote({required dynamic key}) async {
    // notesList.removeAt(index);
    await box.delete(key);
    refreshNoteKeyList();
  }

  static Future<void> editNote({
    required dynamic key,
    required NoteModel item,
  }) async {
    // notesKeyList[index] = item;
    await box.put(key, item.toMap());
    refreshNoteKeyList();
  }

  static List<Color> bgColorList = [
    ColorConstants.color1,
    ColorConstants.color2,
    ColorConstants.color3,
    ColorConstants.color4,
  ];

  static void refreshNoteKeyList() {
    notesKeyList = box.keys.toList();
  }
}
