// ignore_for_file: file_names, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var body;
  final DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${date}',
                style: const TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Note Description",
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    onChanged: (_val) {
                      body = _val;
                    },
                    maxLines: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('Note');

    var data = {
      'body': body,
      'date': date,
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
