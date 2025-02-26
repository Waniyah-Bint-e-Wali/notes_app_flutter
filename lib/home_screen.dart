import 'package:flutter/material.dart';
import 'package:notes_app_flutter/add_update_note.dart';
import 'package:notes_app_flutter/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [
    Note(1, "Task1", "Description"),
    Note(2, "Task2", "Description"),
    Note(3, "Task3", "Description"),
    Note(4, "Task4", "Description"),
  ];

  final List<Color> containerColors = [
    Colors.yellow.shade200,
    Colors.pink.shade200,
    Colors.green.shade200,
    Colors.orange.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        toolbarHeight:100,
        title: Center(
          child: Text(
            "Good Notes",
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'FontMain',
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue.shade300,
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return CustomNoteCard(
              color: containerColors[index % containerColors.length],
              note: notes[index],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> AddUpdateNote()));
          },
          backgroundColor: Colors.pink.shade200,
          child: Icon(Icons.add, size: 35, color: Colors.black),
        ),
      ),
    );
  }
}

class CustomNoteCard extends StatelessWidget {
  final Color color;
  final Note note;

  const CustomNoteCard({super.key, required this.color, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: ListTile(
          title: Text(
            note.title,
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'FontMain',
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            note.description,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.edit, size: 30, color: Colors.black),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, size: 30, color: Colors.black),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
