import 'package:card_accumulator/screens/add_holder_form.dart';
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
              fontSize: 19,
              fontWeight: FontWeight.w400,
              foreground: Paint()..shader = linearGradient,
              letterSpacing: 0.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(child: content),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          final route=MaterialPageRoute(builder: 
          (context)=>AddHolderScreen());
          await Navigator.push(context, route);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21)
        ),
        icon: Icon(
          Icons.group_add,
        ),
        tooltip: "Add a Holder to the holders page",
        focusColor: Colors.deepPurple.shade200,
        hoverColor: Colors.deepPurple.shade200,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 12,
        label: Text("Add Holder"),
      ),
       backgroundColor: Color(0xFF1c1527),
    );
  }
}
