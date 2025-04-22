import 'package:flutter/material.dart';
import 'package:notes_app_flutter/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:notes_app_flutter/notes_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotesProvider()..getAllNotes(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body:
      Container(

      )
    );
  }
}
