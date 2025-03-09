import 'package:flutter/material.dart';
import 'package:notes_app_flutter/add_update_note.dart';
import 'package:notes_app_flutter/note.dart';
import 'package:notes_app_flutter/Database_service.dart';
import 'package:notes_app_flutter/View_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseinstance = DatabaseService.instance;
  List<Note> notes = [];
  @override
  void initState(){
    super.initState();
    fetchnotes();
  }
  void fetchnotes() async {
    final fetchedNotes = await _databaseinstance.getnotes();
    setState(() {
      notes = fetchedNotes;
    });
  }


  final List<Color> containerColors = [
    Colors.yellow.shade200,
    Colors.pink.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        toolbarHeight: 100,
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
        child: notes.isEmpty
      ? Center(
      child: Text(
        "No Notes Added",
        style: TextStyle(fontSize: 25, color: Colors.black,fontFamily:'FontMain'),
      ),
    )
        :
        ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return CustomNoteCard(
                color: containerColors[index % containerColors.length],
                note: notes[index],
                onEdit: (editedNote) {
                  setState(() {
                    notes[index] = editedNote;
                  });
                },
                onDelete: ()async {

                    await _databaseinstance.deletenotes(notes[index]);
                    notes.removeAt(index);
                    setState(() {
                    });
                }
                  );
          }
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20),
        child: FloatingActionButton(
          onPressed: () async {
            final response = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUpdateNote()),
            );

            if (response != null && response is Note) {
              int insertedId = await _databaseinstance.addnotes(response);
              response.id = insertedId;
              List<Note> allNotes = await _databaseinstance.getnotes();
              setState(() {
                notes = allNotes;
              });
            }

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
  final Function(Note) onEdit;
  final Function onDelete;
  const CustomNoteCard({super.key, required this.color, required this.note, required this.onEdit,required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: InkWell(
        onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewNoteScreen(note: note)));
        },
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
              onPressed: () async {
                final editedNote = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUpdateNote(note: note)),
                );

                if (editedNote != null) {
                  onEdit(editedNote);
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, size: 30, color: Colors.black),
              onPressed: () {
                onDelete();
              },
            ),
          ),
        ),
      ),
    );
  }
}
