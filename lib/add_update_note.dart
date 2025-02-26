import 'package:flutter/material.dart';
import 'package:notes_app_flutter/note.dart';

class AddUpdateNote extends StatefulWidget {
  const AddUpdateNote({super.key});

  @override
  State<AddUpdateNote> createState() => _AddUpdateNoteState();
}

class _AddUpdateNoteState extends State<AddUpdateNote> {
  var titleText=TextEditingController();
  var descriptionText=TextEditingController();
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
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            height: 750,
            width: 400,
            color: Colors.blue.shade300,
            child: Column(
              children: [
                // Title Input
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: TextField(
                      controller:titleText,
                      style:  TextStyle(
                      fontSize: 40,
                      fontFamily: 'FontMain',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle:  TextStyle(
                        fontSize: 40,
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.pink.shade200,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: TextField(
                      controller:descriptionText,
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'FontMain',
                        color: Colors.black,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(
                        fontSize: 25,
                        fontFamily: 'FontMain',
                        color: Colors.black,
                      ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 150),
        child: FloatingActionButton(
          onPressed: () {
           String title=titleText.text.toString();
           String description=descriptionText.text.toString();
           Navigator.pop(context, {'title': title, 'description': description});
          },
          backgroundColor: Colors.orange.shade200,
          child: Icon(Icons.check, size: 45, color: Colors.black),
        ),
      ),
    );
  }
}