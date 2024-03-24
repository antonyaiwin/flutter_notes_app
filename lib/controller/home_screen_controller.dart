import 'package:notes_app/model/note_model.dart';

class NotesScreenController {
  static List<NoteModel> notesList = [];

  static void addNote() {
    notesList.add(
      NoteModel(
          title: 'title',
          description: 'description',
          date: 'date',
          colorIndex: 'colorIndex'),
    );
  }
}
