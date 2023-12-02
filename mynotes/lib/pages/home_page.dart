import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/app_style.dart/app_style.dart';
import 'package:mynotes/components/note_card.dart';
import 'package:mynotes/pages/note_editor_page.dart';
import 'package:mynotes/pages/view_note_page.dart';
import 'package:mynotes/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // firestore class instance
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  final textController = TextEditingController();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteEditorPage(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Recent Notes',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNotesStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // final title = snapshot.data!.docs.
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: snapshot.data!.docs
                          .map(
                            (note) => noteCard(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewNotePage(doc: note),
                                ),
                              );
                              // Above is the onTap function so that we can view the note in full screen
                            }, note),
                          )
                          .toList(),
                    );
                  } else {
                    return const Text("No Notes..");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
