import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/core/constants/color_constants.dart';
import 'package:notes_app/model/note_model.dart';

import '../../../controller/note_screen_controller.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
    required this.onComplete,
    this.isEdit = false,
    this.item,
    this.noteKey,
  });
  final void Function()? onComplete;
  final bool isEdit;
  final NoteModel? item;
  final dynamic noteKey;

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
      padding: const EdgeInsets.all(15).copyWith(top: 25),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                minLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                    dateController.text =
                        DateFormat('MMM dd, yyyy').format(date);
                  }
                },
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                  suffixIcon: Icon(Icons.calendar_month),
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
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      height: selectedColorIndex == index ? 55 : 45,
                      width: selectedColorIndex == index ? 55 : 45,
                      decoration: BoxDecoration(
                        color: NotesScreenController.bgColorList[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      if (widget.isEdit) {
                        await NotesScreenController.editNote(
                          key: widget.noteKey!,
                          item: NoteModel(
                            title: titleController.text,
                            description: descriptionController.text,
                            date: dateController.text,
                            colorIndex: selectedColorIndex,
                          ),
                        );
                      } else {
                        await NotesScreenController.addNote(
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
                    borderRadius: BorderRadius.circular(5),
                    child: Ink(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.inputFillColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          widget.isEdit ? 'Save' : 'Add',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Ink(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.inputFillColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
