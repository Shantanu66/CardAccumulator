import 'dart:async';

import 'package:card_accumulator/screens/add_cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:card_accumulator/screens/add_cards_screen.dart';

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
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _professionController = TextEditingController();
  final _mailController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  var currentHolderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add a Holder",
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
            color: Colors.yellowAccent,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1c1527),
      body: Padding(
        
        padding: const EdgeInsets.only(top: 100.0),
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
                  Colors.yellow,
                  Colors.purple.shade600,

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
                    document: gql(addholder()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      print(data.toString());
                      setState(() {
                        currentHolderId=data["createHolder"]["id"];
                        
                      });
                    },
                  ),
                  builder: (runMutation, result) {
                    void _doSomething() async {
                      Timer(Duration(milliseconds: 100), () {
                        // ignore: unnecessary_this
                        this.setState(() {
                          if (_formkey.currentState!.validate()) {
                            runMutation({
                              "name": _nameController.text.trim(),
                              "age": int.parse(_ageController.text.trim()),
                              "profession": _professionController.text.trim(),
                              "mail": _mailController.text.trim(),
                            });
                            _nameController.clear();
                            _ageController.clear();
                            _professionController.clear();
                            _mailController.clear();

                            final route = MaterialPageRoute(
                                builder: (context) => AddCardsScreen(
                                  cid: currentHolderId,
                                ));
                            Navigator.push(context, route);
                          

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
                      key: _formkey,
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
                              hintText: "Enter holder name",
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
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Name can't be empty";
                              }
                              return null;
                            },
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
                              hintText: "Enter your age",
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
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Age can't be empty";
                              }
                              return null;
                            },
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
                              hintText: "Enter your profession",
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
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Profession can't be empty";
                              }
                              return null;
                            },
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
                              hintText: "Enter your email",
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
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email can't be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RoundedLoadingButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 12),
                              child: Text('Add Holder',
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

  String addholder() {
    return """
      mutation createHolder(
        \$name:String!,\$age:Int!,\$profession:String!,\$mail:String!
  ){
    createHolder(name:\$name,
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
