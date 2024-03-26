import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/note_model.dart';

import '../../../controller/note_screen_controller.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
    required this.onComplete,
    this.isEdit = false,
    this.item,
    this.index,
  });
  final void Function()? onComplete;
  final bool isEdit;
  final NoteModel? item;
  final int? index;

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedColorIndex = 0;
  @override
  void initState() {
    if (widget.item != null) {
      titleController.text = widget.item!.title;
      descriptionController.text = widget.item!.description;
      dateController.text = widget.item!.date;
      selectedColorIndex = widget.item!.colorIndex;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add title';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please add description';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  dateController.text = DateFormat('MMM dd, yyyy').format(date);
                }
              },
              controller: dateController,
              decoration: InputDecoration(
                hintText: 'Date',
                hintStyle: const TextStyle(color: Colors.black54),
                suffixIcon: const Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                NotesScreenController.bgColorList.length,
                (index) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: NotesScreenController.bgColorList[index],
                        borderRadius: BorderRadius.circular(10),
                        border: selectedColorIndex == index
                            ? Border.all(
                                color: Colors.black,
                                width: 5,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              )
                            : null),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (widget.isEdit) {
                      NotesScreenController.editNote(
                        index: widget.index!,
                        item: NoteModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: dateController.text,
                          colorIndex: selectedColorIndex,
                        ),
                      );
                    } else {
                      NotesScreenController.addNote(
                        item: NoteModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: dateController.text,
                          colorIndex: selectedColorIndex,
                        ),
                      );
                    }

                    Navigator.pop(context);
                    widget.onComplete!();
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.isEdit ? 'Save' : 'Add',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
