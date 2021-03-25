import 'package:flutter/material.dart';
import 'package:notes_app/widgets/note_previews.dart';
import 'package:notes_app/services/saved_notes.dart';
import 'package:notes_app/services/note.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SavedNotes db = SavedNotes();
  List<Widget> notePreviews = [];

  loadNotes() async {
    List<Note> noteList = await db.retrieveAllNotes();
    setState(() {
      notePreviews = List.generate(noteList.length, (i) {
        return InkWell(
          onTap: () async {
            await Navigator.pushNamed(context, '/note', arguments: {
              'id': noteList[i].id, 'isNew': false, 'titleText': noteList[i].title, 'contentText': noteList[i].content
            });
            loadNotes();
          },
          child: NotePreview(
            id: noteList[i].id,
            title: noteList[i].title,
            content: noteList[i].content,
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {

    //db.initDB();

    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange[400],
          leading: Container(),
          title: Text("NOTES"),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width*2, 450.0)
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: notePreviews,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic result = await Navigator.pushNamed(context, '/note',  arguments: {'id': 0, 'isNew': true, 'titleText': "New Note", 'contentText': ""});
            List<Note> noteList = await db.retrieveAllNotes();
            loadNotes();
          },
          child: Icon(
            Icons.add_circle_outlined,
            size: 30.0,
          ),
          tooltip: "Create New Note",
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange[600],
          elevation: 0.0,
        ),
      ),
    );
  }
}
