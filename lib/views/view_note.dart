import 'package:flutter/material.dart';
import 'package:notes_app_flutter/models/note.dart';

class ViewNoteScreen extends StatelessWidget {
  final Note note;

  const ViewNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Center(
          child: Text(
            "Good Notes",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'FontMain',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        height:500,
        width:double.infinity,
        color: Colors.blue.shade300,
        padding: EdgeInsets.all(20),
        child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),] ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  note.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 20),
                Text(
                  note.description,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),


      ),)
    );
  }
}
