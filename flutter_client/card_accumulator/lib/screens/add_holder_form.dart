import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddHolderScreen extends StatefulWidget {
  const AddHolderScreen({ Key? key }) : super(key: key);

  @override
  _AddHolderScreenState createState() => _AddHolderScreenState();
}

class _AddHolderScreenState extends State<AddHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add a Holder",
          style: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.deepPurple,
              letterSpacing: 0.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      );
  }
}