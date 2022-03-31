import 'dart:io';

import 'package:camera_app/db_functions.dart';
import 'package:camera_app/main.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({Key? key, required this.imagepath, required this.index})
      : super(key: key);
  final imagepath;
  final index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                deletedialogbox(context, index);
              },
              icon: Icon(Icons.delete_outline))
        ],
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Image.file(File(imagepath))),
    );
  }

  deletedialogbox(BuildContext context, index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete this item'),
            actions: [
              ElevatedButton.icon(
                  onPressed: () {
                    deleteimage(index);

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete')),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'))
            ],
          );
        });
  }
}
