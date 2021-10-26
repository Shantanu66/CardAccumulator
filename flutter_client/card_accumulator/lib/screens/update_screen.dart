import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:card_accumulator/screens/add_cards_screen.dart';

class UpdateScreen extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String profession;
  const UpdateScreen({
     Key? key,
     required this.id, 
     required this.name,
     required this.age,
     required this.profession
  }) : super(key: key);
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}
final Shader linearGradient = LinearGradient(
  colors:  <Color>[Colors.white, Colors.greenAccent.shade400],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update ${widget.name}",
          style: GoogleFonts.openSans(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              //color: Colors.white,
              letterSpacing: 1.0,
              foreground: Paint()..shader = linearGradient),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1c1527)),
          onPressed: () => {},
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close_sharp),
            color: Colors.redAccent,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1c1527),
    );
  }
}