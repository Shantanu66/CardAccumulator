import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_fonts/google_fonts.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({Key? key}) : super(key: key);

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

final Shader linearGradient = LinearGradient(
  colors: const <Color>[Colors.white, 
   Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _HomeScreenStateState extends State<HomeScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "\nHolders",
          style: GoogleFonts.openSans(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              foreground: Paint()..shader = linearGradient,
              letterSpacing: 0.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
