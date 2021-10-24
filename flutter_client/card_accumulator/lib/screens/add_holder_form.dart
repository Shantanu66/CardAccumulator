import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddHolderScreen extends StatefulWidget {
  const AddHolderScreen({Key? key}) : super(key: key);

  @override
  _AddHolderScreenState createState() => _AddHolderScreenState();
}

final Shader linearGradient = LinearGradient(
  colors: const <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _AddHolderScreenState extends State<AddHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add a Holder",
          style: GoogleFonts.openSans(
              fontSize: 18,
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
            color: Colors.white,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1c1527),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  color: Colors.grey.shade300,
                  blurRadius: 30),
            ],
          ),
          child:Column(
            children: [
              Mutation(options: options, builder: builder)
            ],
          ),
        ),
      ),
    );
  }
}
