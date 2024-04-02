import 'package:flutter/material.dart';
import 'package:notes_app/controller/note_screen_controller.dart';
import 'package:notes_app/view/home_screen/widgets/add_note_form.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/note_model.dart';
import 'widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NotesScreenController.refreshNoteKeyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notes'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          var noteKey = NotesScreenController.notesKeyList[index];
          NoteModel item =
              NoteModel.fromMap(NotesScreenController.box.get(noteKey));

          return NoteCard(
            item: item,
            onDeletePressed: () async {
              await NotesScreenController.deleteNote(key: noteKey);
              setState(() {});
            },
            onEditPressed: () {
              showCustomBottomSheet(
                context: context,
                isEdit: true,
                noteModel: item,
                noteKey: noteKey,
              );
            },
            onSharePressed: () {
              Share.share(
                "${item.title}\n${item.description}",
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemCount: NotesScreenController.notesKeyList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomBottomSheet(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showCustomBottomSheet(
      {required BuildContext context,
      bool isEdit = false,
      NoteModel? noteModel,
      dynamic noteKey}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddNoteForm(
          onComplete: () {
            setState(() {});
          },
          isEdit: isEdit,
          item: noteModel,
          noteKey: noteKey,
        );
      },
    );
  }
}
