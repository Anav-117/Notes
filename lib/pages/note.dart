import 'package:flutter/material.dart';
import 'package:notes_app/services/note.dart';
import 'package:notes_app/services/saved_notes.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  SavedNotes db = SavedNotes();
  bool isEditingContent = false;
  bool isEditingTitle = false;
  TextEditingController _editingController;
  TextEditingController _titleController;
  String contentText = "";
  String titleText = "";
  bool isNew = true;
  // ignore: non_constant_identifier_names
  int ID = 0;
  String changedValue = "";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: contentText);
    _titleController = TextEditingController(text: titleText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    isNew = (data['isNew'] == false) ? false : true;
    ID = (data['id'] > 0) ? data['id'] : 0;
    titleText = (titleText == "") ? data['titleText'] : titleText;
    contentText = (contentText == "") ? data['contentText'] : contentText;

    return WillPopScope(
      onWillPop: () async {
        Note newNote = (!isNew) ? Note(id: ID, title: titleText, content: contentText) : Note(title: titleText, content: contentText);
        //print(newNote.title);
        await db.insertNote(newNote);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            FloatingActionButton(
              heroTag: 'deleteBtn',
              onPressed: () async {
                if (ID > 0) {
                  await db.deleteNote(ID);
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.delete_outline, size: 30),
              foregroundColor: Colors.white,
              tooltip: "Delete",
              backgroundColor: Colors.orange[400],
              elevation: 0.0,
            ),
          ],
          backgroundColor: Colors.orange[400],
          title: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 30.0, 0.0),
            child: _editableTitleField(20.0, Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _editableTextField(17.50, Colors.white),
        ),
        ),
    );
  }

  Widget _editableTextField(double size, Color color) {
    changedValue = contentText;
    if (isEditingContent) {
      return Center(
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (newValue) {
            contentText = newValue;
          },
          onEditingComplete: () {
            isEditingContent = false;
          },
          onTap: () {
            isEditingContent = false;
          },
          autofocus: true,
          controller: _editingController..text = contentText,
          style: TextStyle(
            color: color,
            fontSize: size,
          )
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          isEditingContent = true;
          isEditingTitle = false;
        });
      },
      splashColor: Colors.orange[400],
      splashFactory: InkRipple.splashFactory,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text(
          contentText,
          style: TextStyle(
            color: color,
            fontSize: size,
          ),
        ),
      ),
    );
  }

  Widget _editableTitleField(double size, Color color) {
    changedValue = contentText;
    if (isEditingTitle) {
      return Center(
        child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (newValue) {
              titleText = newValue;
            },
            autofocus: true,
            controller: _titleController..text = titleText,
            style: TextStyle(
              color: color,
              fontSize: size,
            )
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          isEditingTitle = true;
          isEditingContent = false;
        });
      },
      splashColor: Colors.orange[400],
      splashFactory: InkRipple.splashFactory,
      child: Text(
        titleText,
        style: TextStyle(
          color: color,
          fontSize: size,
        ),
      ),
    );
  }
}

