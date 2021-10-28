import 'package:card_accumulator/screens/holder_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:card_accumulator/screens/holder_page.dart';
import 'package:card_accumulator/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:card_accumulator/screens/add_cards_screen.dart';

class EditIdcardScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String cardnumber;
  final String DOB;
  const EditIdcardScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.cardnumber,
    required this.DOB,
  }) : super(key: key);

  @override
  _EditIdcardScreenState createState() => _EditIdcardScreenState();
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _EditIdcardScreenState extends State<EditIdcardScreen> {
  final _editkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _numberController = TextEditingController();
  final _DOBController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  var currentHolderId;
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _descController.text = widget.description;
    _numberController.text = widget.cardnumber;
    _DOBController.text = widget.DOB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit ${widget.title}",
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
                  Colors.pinkAccent.shade100,
                  Colors.pink.shade400,

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
                    document: gql(editid()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      _btnController.success();
                      _btnController.reset();
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
                              "title": _titleController.text.trim(),
                              "description": _descController.text,
                              "cardnumber": _numberController.text,
                              "DOB": _DOBController.text,
                            });
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
                            controller: _titleController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Card Type",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit card type name",
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
                            controller: _descController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "description",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit description",
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
                            controller: _numberController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "card number",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "XXXX XXXX XXXX XXXX/ABXXXXXX",
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
                            controller: _DOBController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "DOB",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit your Date of birth",
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

  String editid() {
    return """
      mutation UpdateIdcard(\$id:String!,
        \$title:String!,\$description:String!,
        \$cardnumber:String!,\$DOB:String!
  ){
    UpdateIdcard(id:\$id,
      title:\$title,
    description:\$description,
    cardnumber:\$cardnumber,
    DOB:\$DOB
    ){
      id
      title
    }
  }
    """;
  }
}
