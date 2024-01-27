// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/app_style.dart/app_style.dart';
import 'package:mynotes/services/firestore.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({Key? key}) : super(key: key);

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  FirestoreService firestoreService = FirestoreService();
  int colorId = Random().nextInt(AppStyle.cardsColor.length);

  String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        title: const Text('Add a new Note'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          firestoreService
              .addNewNote(
                  _mainController.text, _titleController.text, date, colorId)
              .then((value) {
            Navigator.pop(context);
          }).catchError((error) => debugPrint(error));
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 30),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: const TextStyle(fontSize: 16),
              controller: _mainController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
