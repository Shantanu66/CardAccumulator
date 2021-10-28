import 'dart:async';

import 'package:card_accumulator/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddCardsScreenNew extends StatefulWidget {
  final String cid;

  AddCardsScreenNew({
    required this.cid,
    Key? key,
  }) : super(key: key);

  @override
  _AddCardsScreenNewState createState() => _AddCardsScreenNewState();
}

class _AddCardsScreenNewState extends State<AddCardsScreenNew> {
  final _controller = ScrollController();
  ScrollPhysics _physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  final Shader linearGradient = LinearGradient(
    colors: const <Color>[Colors.white, Colors.deepPurpleAccent],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
  );

  final _idCardkey = GlobalKey<FormState>();

  //idcards
  final _titleController = TextEditingController();
  final _DescController = TextEditingController();
  final _CardNumberController = TextEditingController();
  final _DOBController = TextEditingController();
  //bankcards
  final _BankController = TextEditingController();
  final _ValidityController = TextEditingController();
  final _NumberController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  var _bankCardkey = GlobalKey<FormState>();

  bool _visible = false;

  var _visible2 = false;

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  void _toggle2() {
    setState(() {
      _visible2 = !_visible2;
    });
  }

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
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close_sharp),
            color: Colors.greenAccent,
          )
        ],
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
                  offset: Offset(0, 5), color: Colors.black, blurRadius: 12),
            ],
          ),
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                    document: gql(insertId()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
                      _btnController.success();
                      _btnController.reset();
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
                          _toggle();
                          _titleController.clear();
                          _DescController.clear();
                          _CardNumberController.clear();
                          _DOBController.clear();

                        } else {
                          _toggle();
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
                            labelStyle: GoogleFonts.sora(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                            fillColor: Colors.white,
                            hoverColor: Colors.purple,
                            hintText: "Name of your Government id type",
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
                            labelStyle: GoogleFonts.sora(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                            fillColor: Colors.white,
                            hoverColor: Colors.purple,
                            hintText: "Purpose of the ID",
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
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Card Number can't be empty";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                            controller: _DOBController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Date of birth",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "DD/MM/YYYY",
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
                            child: Text('Add card',
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
              SizedBox(
                height: 30,
              ),
              //BANK SECTION
              Visibility(
                visible: _visible,
                child: Mutation(
                  options: MutationOptions(
                      document: gql(insertBank()),
                      fetchPolicy: FetchPolicy.noCache,
                      onCompleted: (data) {
                        _btnController.success();
                        _btnController.reset();
                      }),
                  builder: (runMutation, result) {
                    void _doSomething() async {
                      Timer(Duration(milliseconds: 100), () {
                        // ignore: unnecessary_this
                        this.setState(() {
                          if (_bankCardkey.currentState!.validate()) {
                            runMutation({
                              "bank": _BankController.text,
                              "validity": _ValidityController.text,
                              "number": _NumberController.text,
                              "holderId": widget.cid
                            });
                            _toggle2();
                            _BankController.clear();
                            _ValidityController.clear();
                            _NumberController.clear();
                          } else {
                            _toggle2();
                            _btnController.error();
                            //_btnController.reset();
                          }
                        });
                      });
                    }

                    return Form(
                      key: _bankCardkey,
                      child: Column(
                        children: [
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _BankController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Bank name",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Name of the Bank",
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
                                return "Bank Name can't be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _ValidityController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Validity",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "MM/YY",
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
                                return "Validity can't be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: _NumberController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Card Number",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "XXXX XXXX XXXX XXXX",
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
                                return "Card Number can't be empty";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RoundedLoadingButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 12),
                              child: Text('Add card',
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
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _visible2,
                child: RoundedLoadingButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 12),
                    child: Text('Done',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 2.0)),
                  ),
                  elevation: 15.0,
                  controller: _btnController,
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreenState();
                    }), (route) => false);
                  },
                  width: 100,
                  height: 43,
                  borderRadius: 50,
                  errorColor: Colors.red,
                ),
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

  String insertBank() {
    return """
    mutation createBankcard(
      \$bank:String!,
    \$validity:String!,\$number:String!,
    \$holderId:String!
    ){
    createBankcard(bank:\$bank,
    validity:\$validity,
    number:\$number,
    holderId:\$holderId
    ){
      id
      bank
    }
  }
  """;
  }
}
