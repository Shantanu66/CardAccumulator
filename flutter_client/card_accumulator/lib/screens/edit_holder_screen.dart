import 'dart:async';

import 'package:card_accumulator/screens/holder_page.dart';
import 'package:card_accumulator/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:card_accumulator/screens/add_cards_screen.dart';

class EditScreen extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String profession;
  final String mail;
  const EditScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.age,
      required this.profession,
      required this.mail})
      : super(key: key);
  @override
  _EditScreenState createState() => _EditScreenState();
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _EditScreenState extends State<EditScreen> {
  final _editkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _professionController = TextEditingController();
  final _mailController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var currentHolderId;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _ageController.text = widget.age.toString();
    _professionController.text = widget.profession;
    _mailController.text = widget.mail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit ${widget.name}",
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
            color: Colors.redAccent,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1c1527),
      body: Padding(
        padding: const EdgeInsets.only(top: 110.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  //Colors.purple.shade300,
                  Colors.tealAccent,
                  Colors.teal,

                  //Colors.deepPurple.shade700
                ],
              ),
              borderRadius: BorderRadius.circular(35),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                // ignore: prefer_const_constructors
                BoxShadow(
                    offset: Offset(0, 10), color: Colors.black, blurRadius: 30),
              ],
            ),
            child: Column(
              children: [
                Mutation(
                  options: MutationOptions(
                    document: gql(editholder()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      print(data.toString());
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return HomeScreenState();
                        },
                      ), (route) => false);
                    },
                  ),
                  builder: (runMutation, result) {
                    void _doSomething() async {
                      Timer(Duration(milliseconds: 100), () {
                        // ignore: unnecessary_this
                        this.setState(() {
                          if (_editkey.currentState!.validate()) {
                            runMutation({
                              "id": widget.id,
                              "name": _nameController.text.trim(),
                              "age": int.parse(_ageController.text.trim()),
                              "profession": _professionController.text.trim(),
                              "mail": _mailController.text.trim(),
                            });

                            _btnController.success();
                            _btnController.reset();
                          } else {
                            _btnController.error();
                            //_btnController.reset();
                          }
                        });
                      });
                    }

                    return Form(
                      key: _editkey,
                      child: Column(
                        children: [
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _nameController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit holder name",
                              hintStyle: GoogleFonts.sora(
                                fontSize: 14.0,
                              ),
                              focusColor: Colors.purpleAccent,
                              // ignore: prefer_const_constructors
                              border: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(20)),
                            ),

                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _ageController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Age",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit your age",
                              hintStyle: GoogleFonts.sora(
                                fontSize: 14.0,
                              ),
                              focusColor: Colors.purpleAccent,
                              // ignore: prefer_const_constructors
                              border: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(20)),
                            ),

                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _professionController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Profession",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit your profession",
                              hintStyle: GoogleFonts.sora(
                                fontSize: 14.0,
                              ),
                              focusColor: Colors.purpleAccent,
                              // ignore: prefer_const_constructors
                              border: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(20)),
                            ),

                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _mailController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit your email",
                              hintStyle: GoogleFonts.sora(
                                fontSize: 14.0,
                              ),
                              focusColor: Colors.purpleAccent,
                              // ignore: prefer_const_constructors
                              border: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(20)),
                            ),

                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RoundedLoadingButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 12),
                              child: Text('Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 2.0)),
                            ),
                            elevation: 15.0,
                            controller: _btnController,
                            color: Colors.deepPurpleAccent,
                            onPressed: _doSomething,
                            width: 100,
                            height: 43,
                            borderRadius: 50,
                            errorColor: Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String editholder() {
    return """
      mutation UpdateHolder(\$id:String!,
        \$name:String!,\$age:Int!,\$profession:String!,\$mail:String!
  ){
    UpdateHolder(id:\$id,
      name:\$name,
    profession:\$profession,
    age:\$age,
    mail:\$mail
    ){
      id
      name
    }
  }
    """;
  }
}
