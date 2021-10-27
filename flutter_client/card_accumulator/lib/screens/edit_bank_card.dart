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

class EditBankcardScreen extends StatefulWidget {
  final String id;
  final String bank;
  final String validity;
  final String number;
  const EditBankcardScreen({
    Key? key,
    required this.id,
    required this.bank,
    required this.validity,
    required this.number,
  }) : super(key: key);

  @override
  _EditBankcardScreenState createState() => _EditBankcardScreenState();
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _EditBankcardScreenState extends State<EditBankcardScreen> {
  final _editbankkey = GlobalKey<FormState>();

  final _bankController = TextEditingController();
  final _valController = TextEditingController();
  final _numberController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  void initState() {
    super.initState();
    _bankController.text = widget.bank;
    _valController.text = widget.validity;
    _numberController.text = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit ${widget.bank}",
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
                    document: gql(editbank()),
                    fetchPolicy: FetchPolicy.noCache,
                    onCompleted: (data) {
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
                          if (_editbankkey.currentState!.validate()) {
                            runMutation({
                              "id": widget.id,
                              "bank": _bankController.text,
                              "validity": _valController.text,
                              "number": _numberController.text,
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
                      key: _editbankkey,
                      child: Column(
                        children: [
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _bankController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Bank Name",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit Bank name",
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
                            controller: _valController,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              labelText: "Validity",
                              labelStyle: GoogleFonts.sora(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              hoverColor: Colors.purple,
                              hintText: "Edit validity",
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

  String editbank() {
    return """
      mutation UpdateBankcard(\$id:String!,
        \$bank:String!,\$validity:String!,
        \$number:String!
  ){
    UpdateBankcard(id:\$id,
      bank:\$bank,
    validity:\$validity,
    number:\$number
    ){
      id
      bank
    }
  }
    """;
  }
}
