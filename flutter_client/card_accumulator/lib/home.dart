import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:google_fonts/google_fonts.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({Key? key}) : super(key: key);

  @override
  _HomeScreenStateState createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Holders",
          style: GoogleFonts.,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
