import 'package:flutter/material.dart';

class NotePreview extends StatelessWidget {
  final String title;
  final String content;
  final int id;

  NotePreview({this.title, this.content, this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 150.0,
              height: 100.0,
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
