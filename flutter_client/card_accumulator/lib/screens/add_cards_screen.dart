import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddCardsScreen extends StatefulWidget {
   var cid;
   AddCardsScreen({
    Key? key,
    @required this.cid,
  }) :super(key: key);
  @override
  _AddCardsScreenState createState() => _AddCardsScreenState();
}

class _AddCardsScreenState extends State<AddCardsScreen> {
  final Shader linearGradient = LinearGradient(
    colors: const <Color>[Colors.white, Colors.deepPurpleAccent],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
  );

  final _idCardkey = GlobalKey<FormState>();
  

  final _titleController = TextEditingController();
  final _DescController = TextEditingController();
  final _CardNumberController = TextEditingController();
  final _DOBController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add your ID and Bank card",
          style: GoogleFonts.openSans(
              fontSize: 17,
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
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.greenAccent,
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
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                //Colors.purple.shade300,
                Colors.blueAccent.shade100,

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
                    document: gql(insertId()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      print(data.toString());
                      print(data["id"]);
                    }),
                builder: (runMutation, result) {
                  void _doSomething() async {
                    Timer(Duration(milliseconds: 100), () {
                      // ignore: unnecessary_this
                      this.setState(() {
                        if (_idCardkey.currentState!.validate()) {
                          runMutation({
                            "title": _titleController.text,
                            "description": _DescController.text,
                            "cardnumber": _CardNumberController.text,
                            "DOB": _DOBController.text,
                            "holderId": widget.cid
                          });
                          _titleController.clear();
                          _DescController.clear();
                          _CardNumberController.clear();
                          _DOBController.clear();
                            print(widget.cid);
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
                    key: _idCardkey,
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
                            labelText: "ID type name",
                            fillColor: Colors.white,
                            hoverColor: Colors.purple,
                            hintText: "Name of your Government id type",
                            focusColor: Colors.purpleAccent,
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(
                                // ignore: prefer_const_constructors
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _DescController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Description",
                            fillColor: Colors.white,
                            hoverColor: Colors.purple,
                            hintText: "Enter what the id is used for",
                            focusColor: Colors.purpleAccent,
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(
                                // ignore: prefer_const_constructors
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Description can't be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: _CardNumberController,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: "Card Number",
                            fillColor: Colors.white,
                            hoverColor: Colors.purple,
                            hintText: "Enter your Card Number",
                            focusColor: Colors.purpleAccent,
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(
                                // ignore: prefer_const_constructors
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Card Number can't be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                            controller: _DOBController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Date of birth",
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Enter your Date of Birth",
                              focusColor: Colors.purpleAccent,
                              // ignore: prefer_const_constructors
                              border: OutlineInputBorder(
                                  // ignore: prefer_const_constructors
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            validator: (value) {
                              if (value!.length == 0) {
                                return "DOB can't be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        SizedBox(
                          height: 12,
                        ),
                        RoundedLoadingButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36, vertical: 12),
                            child: Text('Add ID card',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 2.0)),
                          ),
                          elevation: 15.0,
                          controller: _btnController,
                          color: Colors.deepPurpleAccent.shade400,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  String insertId() {
    return """
    mutation createIDcard(
      \$title:String!,
    \$description:String!,\$cardnumber:String!,\$DOB:String!,
    \$holderId:String!
    ){
    createIDcard(title:\$title,
    description:\$description,
    cardnumber:\$cardnumber,
    DOB:\$DOB,
    holderId:\$holderId
    ){
      id
      title
    }
  }
  """;
  }
}
