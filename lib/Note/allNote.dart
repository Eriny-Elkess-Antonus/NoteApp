// ignore_for_file: file_names, unused_local_variable, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'addNote.dart';
import 'viewNote.dart';

class AllNote extends StatefulWidget {
  const AllNote({
    Key? key,
  }) : super(key: key);

  @override
  State<AllNote> createState() => _AllNoteState();
}

class _AllNoteState extends State<AllNote> {
  CollectionReference ref = FirebaseFirestore.instance.collection('Note');

  @override
  Widget build(BuildContext context) {
    String deletedNoteDate = "";
    String deletedNoteDescription = "";
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              separatorBuilder: (_, __) => const SizedBox.square(dimension: 12),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                Map data = snapshot.data!.docs[index].data() as Map;
                DateTime mydateTime = data['date'].toDate();
                String formattedTime =
                    DateFormat.yMMMd().add_jm().format(mydateTime);
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      deletedNoteDate = data['date'].toDate();
                      deletedNoteDescription = data['body'];
                      data['date'].toDate().removeAt(index);

                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.purple,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Note Deleted",
                                style: TextStyle(),
                              ),
                              deletedNoteDate != ""
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (deletedNoteDate != "") {
                                            data['date']
                                                .toDate()
                                                .add(deletedNoteDate);
                                            data['body']
                                                .toDate()
                                                .add(deletedNoteDescription);
                                          }
                                          deletedNoteDate = "";
                                          deletedNoteDescription = "";
                                        });
                                      },
                                      child: const Text(
                                        "done",
                                        style: TextStyle(),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ViewNote(
                            data: data,
                            ref: snapshot.data!.docs[index].reference,
                            time: formattedTime,
                          ),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "${data['body']}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                formattedTime,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
