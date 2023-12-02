import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app_style.dart/app_style.dart';
import 'package:mynotes/services/firestore.dart';

class ViewNotePage extends StatefulWidget {
  final QueryDocumentSnapshot doc;
  const ViewNotePage({required this.doc, Key? key}) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePage();
}

class _ViewNotePage extends State<ViewNotePage> {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['note_title'], style: const TextStyle(fontSize: 30),),
            const SizedBox(
              height: 10,
            ),
            Text(widget.doc['timestamp'].toString(), style: const TextStyle(fontSize: 17),),
            const SizedBox(
              height: 28,
            ),
            Text(
              widget.doc['note'],
              style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
