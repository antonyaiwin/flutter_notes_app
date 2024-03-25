import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/color_constants.dart';
import 'package:notes_app/model/note_model.dart';

class NotesScreenController {
  static List<NoteModel> notesList = [];

  static void addNote({required NoteModel item}) {
    notesList.add(item);
  }

  static void deleteNoteAt({required int index}) {
    notesList.removeAt(index);
  }

  static void editNote({
    required int index,
    required NoteModel item,
  }) {
    notesList[index] = item;
  }

  static List<Color> bgColorList = [
    ColorConstants.color1,
    ColorConstants.color2,
    ColorConstants.color3,
    ColorConstants.color4,
  ];
}
