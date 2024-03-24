import 'package:flutter/material.dart';
import 'package:notes_app/controller/home_screen_controller.dart';
import 'package:notes_app/view/home_screen/widgets/add_note_form.dart';

import 'widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          return NoteCard(
            item: NotesScreenController.notesList[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemCount: NotesScreenController.notesList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddNoteForm(
                setState: setState,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
