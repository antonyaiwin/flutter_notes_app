import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/color_constants.dart';

import '../../../model/note_model.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.item,
  });
  final NoteModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.color1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: Text('title')),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          const Text('Description'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Sun, Mar 24, 2024'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
              )
            ],
          )
        ],
      ),
    );
  }
}
