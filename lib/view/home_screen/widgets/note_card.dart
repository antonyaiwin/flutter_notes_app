import 'package:flutter/material.dart';
import 'package:notes_app/controller/note_screen_controller.dart';

import '../../../model/note_model.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.item,
    this.onDeletePressed,
    this.onEditPressed,
    this.onSharePressed,
  });
  final NoteModel item;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;
  final void Function()? onSharePressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: NotesScreenController.bgColorList[item.colorIndex]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(item.title)),
              IconButton(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          Text(item.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(item.date),
              IconButton(
                onPressed: onSharePressed,
                icon: const Icon(Icons.share),
              )
            ],
          )
        ],
      ),
    );
  }
}
