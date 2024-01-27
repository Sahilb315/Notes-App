import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app_style.dart/app_style.dart';
import 'package:mynotes/services/firestore.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  FirestoreService firestoreService = FirestoreService();
  String docID = doc.id;
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(doc['note_title']),
              IconButton(
                onPressed: () {
                  firestoreService.deleteNote(docID);
                },
                icon: const Icon(
                  Icons.clear_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(doc['timestamp'].toString()),
          const SizedBox(
            height: 10,
          ),
          Text(
            doc['note'],
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
  );
}
