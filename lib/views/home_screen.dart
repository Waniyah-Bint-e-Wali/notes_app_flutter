import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app_flutter/views/add_update_note.dart';
import 'package:notes_app_flutter/models/note.dart';
import 'package:notes_app_flutter/provider/notes_provider.dart';
import 'package:notes_app_flutter/views/view_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).getAllNotes();
  }

  final List<Color> containerColors = [
    Colors.yellow.shade200,
    Colors.pink.shade200,
    Colors.orange.shade200,
    Colors.green.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
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
        color: Colors.blue.shade300,
        child: notes.isEmpty
            ? Center(
          child: Text(
            "No Notes Added",
            style: TextStyle(fontSize: 25, color: Colors.black, fontFamily: 'FontMain'),
          ),
        )
            : ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return CustomNoteCard(
              color: containerColors[index % containerColors.length],
              note: notes[index],
              onEdit: (editedNote) async {
                await noteProvider.updateNote(editedNote);
              },
              onDelete: () async {
                await noteProvider.deleteNote(notes[index]);
              },
            );
          },
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
              await noteProvider.addNote(response);
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

  const CustomNoteCard({
    super.key,
    required this.color,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewNoteScreen(note: note)),
          );
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
                fontSize: 25,
                fontFamily: 'FontMain',
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            subtitle: Container(
              height: 70,
              child: SingleChildScrollView(
                child: Text(
                  note.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.edit, size: 25, color: Colors.black),
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
              icon: Icon(Icons.delete, size: 25, color: Colors.black),
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
