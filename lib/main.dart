import 'package:flutter/material.dart';
import 'package:notes_app/pages/home.dart';
import 'package:notes_app/pages/note.dart';
import 'package:notes_app/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    //home: Home(),
    initialRoute: '/',
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(),
      '/note' : (context) => NotePage(),
    }
  ));
}