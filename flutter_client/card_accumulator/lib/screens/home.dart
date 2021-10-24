import 'package:card_accumulator/screens/add_holder_page.dart';
import 'package:card_accumulator/screens/holder_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_fonts/google_fonts.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({Key? key}) : super(key: key);

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

final Shader linearGradient = LinearGradient(
  colors: const <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _HomeScreenStateState extends State<HomeScreenState> {
  @override
  Widget build(BuildContext context) {
    Widget content = HoldersScreen();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "\nHolders",
          style: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              foreground: Paint()..shader = linearGradient,
              letterSpacing: 0.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(child: content),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final route=MaterialPageRoute(builder: 
          (context)=>AddHolderScreen());
          await Navigator.push(context, route);
        },
        child: Icon(
          Icons.group_add,
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
       backgroundColor: Color(0xFF1c1527),
    );
  }
}
