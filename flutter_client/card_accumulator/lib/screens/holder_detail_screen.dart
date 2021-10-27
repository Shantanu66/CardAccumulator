import 'package:card_accumulator/screens/add_cards_new.dart';
import 'package:card_accumulator/screens/add_cards_screen.dart';
import 'package:card_accumulator/screens/edit_bank_card.dart';
import 'package:card_accumulator/screens/edit_id_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_button/animated_button.dart';

class DetailsPage extends StatefulWidget {
  final dynamic holder;

  const DetailsPage({Key? key,  this.holder}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

final Shader linearGradient = LinearGradient(
  colors: const <Color>[Colors.white, Colors.deepPurpleAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _DetailsPageState extends State<DetailsPage> {
  final _controller = ScrollController();
  ScrollPhysics _physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  bool pressAttention = false;

  List _idcards = [];
  List _bankcards = [];
  bool _isidcardvisible = false;
  bool _isbankcardvisible = false;

  void _visibleidcard() {
    setState(() {
      _isidcardvisible = true;
      _isbankcardvisible = false;
    });
  }

  void _visiblebankcard() {
    setState(() {
      _isidcardvisible = false;
      _isbankcardvisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.holder["name"],
          style: GoogleFonts.openSans(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              //color: Colors.white,
              letterSpacing: 1.0,
              foreground: Paint()..shader = linearGradient),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_downward_rounded),
            color: Colors.greenAccent,
          )
        ],
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1c1527),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
              margin: const EdgeInsets.only(
                  bottom: 23, left: 19, right: 19, top: 20),
              // ignore: duplicate_ignore
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // ignore: prefer_const_constructors
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Colors.purple.shade300,
                    Colors.deepPurple,
                    Colors.purple,

                    //Colors.deepPurple.shade700
                  ],
                ),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  // ignore: prefer_const_constructors
                  BoxShadow(
                    offset: const Offset(2, 6),
                    color: Colors.purple,
                    blurRadius: 19,
                    spreadRadius: -2.5,
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),

              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.holder["name"]}",
                          style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 2.0),
                          child: Text(
                            "Age : ${widget.holder["age"] ?? 'N/A'}",
                            style: GoogleFonts.raleway(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 2.0, bottom: 1.0),
                      child: Text(
                        "Profession : ${widget.holder["profession"] ?? 'N/A'}",
                        style: GoogleFonts.raleway(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 1.0),
                      child: Text(
                        "Email : ${widget.holder["mail"] ?? 'N/A'}",
                        style: GoogleFonts.raleway(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 280.0, top: 0.0),
                          child: InkWell(
                            child: Icon(Icons.add_box,
                            color: Colors.greenAccent.shade400,),
                            onTap: () async {
                              final route = MaterialPageRoute(
                                  builder: (context) => AddCardsScreenNew(
                                        cid: widget.holder["id"],
                                      ));
                              Navigator.push(context, route);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),

                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      //Colors.purple.shade300,

                      Colors.deepPurple,
                      Colors.purple,
                      //Colors.deepPurple.shade700
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: TextButton(
                  onPressed: () {
                    _visibleidcard();
                    setState(() {
                      _idcards = widget.holder["idcards"];
                    });
                  },
                  child: Text(
                    "My ID cards",
                    style: GoogleFonts.roboto(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextButton(
                  onPressed: () {
                    _visiblebankcard();
                    setState(() {
                      _bankcards = widget.holder["bankcards"];
                    });
                  },
                  child: Text(
                    "My Bank cards",
                    style: GoogleFonts.roboto(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: _isidcardvisible,
            child: Container(
              height: 500,
              child: ListView.builder(
                controller: _controller,
                physics: _physics,
                itemCount: _idcards.length,
                itemBuilder: (context, index) {
                  var data = _idcards[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 23, left: 19, right: 19, top: 20),
                        // ignore: duplicate_ignore
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          // ignore: prefer_const_constructors
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              //Colors.purple.shade300,
                              Colors.indigo.shade800,
                              Colors.blue,

                              //Colors.deepPurple.shade700
                            ],
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            // ignore: prefer_const_constructors
                            BoxShadow(
                              offset: const Offset(2, 6),
                              color: Colors.blue,
                              blurRadius: 19,
                              spreadRadius: -2.5,
                            )
                          ],
                        ),
                        
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data["title"]}",
                                    style: GoogleFonts.raleway(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 15.0),
                                child: Text(
                                  "Description : ${data["description"]}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 6.0),
                                child: Text(
                                  "Card Number : ${data["cardnumber"]}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 6.0,bottom: 6.0),
                                child: Text(
                                  "DOB : ${data["DOB"]}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2.0,
                        left: 120.0,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(9.0),
                          shape: CircleBorder(),
                          elevation: 15.0,
                          fillColor: Colors.grey.shade900,
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.green,
                            size: 27.0,
                          ),
                          // ignore: avoid_print
                          onPressed: () async {
                            final route = MaterialPageRoute(
                              builder: (context) {
                                return EditIdcardScreen(
                                    id: data['id'],
                                    title: data['title'],
                                    description: data['description'],
                                    cardnumber: data['cardnumber'],
                                    DOB: data["DOB"]);
                              },
                            );
                            await Navigator.push(context, route);
                            
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: _isbankcardvisible,
            child: Container(
              height: 500,
              child: ListView.builder(
                controller: _controller,
                physics: _physics,
                itemCount: _bankcards.length,
                itemBuilder: (context, index) {
                  var data2 = _bankcards[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 23, left: 19, right: 19, top: 20),
                        // ignore: duplicate_ignore
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          // ignore: prefer_const_constructors
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              //Colors.purple.shade300,
                              Colors.red,
                              Colors.yellow.shade600,

                              //Colors.deepPurple.shade700
                            ],
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            // ignore: prefer_const_constructors
                            BoxShadow(
                              offset: const Offset(2, 6),
                              color: Colors.yellow.shade600,
                              blurRadius: 19,
                              spreadRadius: -2.5,
                            )
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                  
                                    "${data2["bank"]}",
                                    style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 6.0),
                                child: Text(
                                  "Validity : ${data2["validity"]}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 6.0,bottom: 8.0),
                                child: Text(
                                  "Card Number : ${data2["number"]}",
                                  style: GoogleFonts.raleway(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2.0,
                        left: 120.0,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(9.0),
                          shape: CircleBorder(),
                          elevation: 15.0,
                          fillColor: Colors.grey.shade900,
                          child: Icon(
                            Icons.edit_rounded,
                            color: Colors.green,
                            size: 27.0,
                          ),
                          // ignore: avoid_print
                          onPressed: () async {
                            print(data2['id']);
                            final route = MaterialPageRoute(
                              builder: (context) {
                                return EditBankcardScreen(
                                    
                                    id: data2['id'],
                                    bank: data2['bank'],
                                    validity: data2['validity'],
                                    number: data2['number'],
                                    );
                              },
                            );
                            await Navigator.push(context, route);
                            
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
