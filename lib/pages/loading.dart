import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notes_app/services/saved_notes.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  SavedNotes db = SavedNotes();


  void loadDatabase() async {
    await db.initDB();
    //print("Load Complete");
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    //print("initialising");
    loadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[400],
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
