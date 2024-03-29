import 'dart:async';
import 'package:card_accumulator/screens/edit_holder_screen.dart';
import 'package:card_accumulator/screens/holder_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HoldersScreen extends StatefulWidget {
  const HoldersScreen({Key? key}) : super(key: key);

  @override
  _HoldersScreenState createState() => _HoldersScreenState();
}

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Colors.purple, Colors.deepPurpleAccent],
).createShader(
  const Rect.fromLTWH(0.0, 0.0, 250.0, 70.0),
);

class _HoldersScreenState extends State<HoldersScreen> {
  final _controller = ScrollController();
  final ScrollPhysics _physics =
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  // ignore: non_constant_identifier_names
  List HolderData = [];
  // ignore: non_constant_identifier_names
  String QUERY = """
      query{
          holders{
              name
              id
              profession
              age
              mail
              idcards{
                id
                title
                description
                cardnumber 
                DOB
                holderId
              }
              bankcards{
                id 
                bank
                validity
                number
                holderId
              }
              }
          }
  """;

  List idcardsdeletelist = [];
  List bankcardsdeletelist = [];

  bool _removeidcard = false;

  bool _removebankcard = false;
  bool _animate = false;

  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(const Duration(milliseconds: 6 * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheAndNetwork, document: gql(QUERY)),
      builder: (QueryResult result,
          {FetchMore? fetchMore, VoidCallback? refetch}) {
        if (result.isLoading) {
          return const SpinKitRipple(color: Colors.white);
        }
        if (result.data == null) {
          return const Text("null");
        }
        HolderData = result.data!["holders"];
        return (HolderData.isNotEmpty)
            ? ListView.builder(
                controller: _controller,
                physics: _physics,
                itemCount: HolderData.length,
                itemBuilder: (context, index) {
                  final holder = HolderData[index];
                  return AnimatedOpacity(
                    duration: Duration(seconds: index),
                    opacity: _animate ? 1 : 0,
                    curve: Curves.easeInOutCubic,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            final route = MaterialPageRoute(builder: (context) {
                              return DetailsPage(
                                holder: holder,
                              );
                            });
                            await Navigator.push(context, route);
                          },
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
                                colors: const [
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
                            child: InkWell(
                              onTap: () async {
                                final route =
                                    MaterialPageRoute(builder: (context) {
                                  return DetailsPage(holder: holder);
                                });
                                await Navigator.push(context, route);
                              },
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
                                          "${holder["name"]}",
                                          style: GoogleFonts.raleway(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 15.0),
                                          child: Text(
                                            "Age : ${holder["age"] ?? 'N/A'}",
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
                                          left: 8.0, top: 1.0, bottom: 1.0),
                                      child: Text(
                                        "Profession : ${holder["profession"] ?? 'N/A'}",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 0.2, bottom: 12.0),
                                      child: Text(
                                        "Email : ${holder["mail"] ?? 'N/A'}",
                                        style: GoogleFonts.raleway(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
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
                        ),
                        Positioned(
                          bottom: 2.0,
                          left: 120.0,
                          child: RawMaterialButton(
                            padding: const EdgeInsets.all(9.0),
                            shape: const CircleBorder(),
                            elevation: 15.0,
                            fillColor: Colors.grey.shade900,
                            child: const Icon(
                              Icons.edit_rounded,
                              color: Colors.green,
                              size: 27.0,
                            ),
                            // ignore: avoid_print
                            onPressed: () async {
                              final route = MaterialPageRoute(
                                builder: (context) {
                                  return EditScreen(
                                      id: holder['id'],
                                      name: holder['name'],
                                      age: holder['age'],
                                      profession: holder['profession'],
                                      mail: holder["mail"]);
                                },
                              );
                              await Navigator.push(context, route);
                            },
                          ),
                        ),
                        Mutation(
                          options: MutationOptions(
                            document: gql(removeholder()),
                            onCompleted: (data) {},
                          ),
                          builder: (runMutation, result) {
                            return Positioned(
                              bottom: 2.0,
                              left: 190.0,
                              child: RawMaterialButton(
                                padding: const EdgeInsets.all(9.0),
                                shape: const CircleBorder(),
                                elevation: 14.0,
                                fillColor: Colors.grey.shade900,
                                child: const Icon(
                                  Icons.delete_sweep_rounded,
                                  color: Colors.red,
                                  size: 27.0,
                                ),
                                // ignore: avoid_print
                                onPressed: () async {
                                  idcardsdeletelist.clear();
                                  bankcardsdeletelist.clear();
                                  for (var i = 0;
                                      i < holder["idcards"].length;
                                      i++) {
                                    idcardsdeletelist
                                        .add(holder["idcards"][i]["id"]);
                                  }
                                  for (var i = 0;
                                      i < holder["bankcards"].length;
                                      i++) {
                                    bankcardsdeletelist
                                        .add(holder["bankcards"][i]["id"]);
                                  }
                                  setState(() {
                                    _removeidcard = true;
                                    _removebankcard = true;
                                  });
                                  runMutation({"id": holder["id"]});
                                },
                              ),
                            );
                          },
                        ),
                        _removeidcard
                            ? Mutation(
                                options: MutationOptions(
                                    document: gql(removeIdcard()),
                                    onCompleted: (data) {}),
                                builder: (runMuation, result) {
                                  if (idcardsdeletelist.isNotEmpty) {
                                    runMuation({'ids': idcardsdeletelist});
                                  }
                                  return Container();
                                },
                              )
                            : Container(),
                        _removebankcard
                            ? Mutation(
                                options: MutationOptions(
                                    document: gql(removeBankcards()),
                                    onCompleted: (data) {}),
                                builder: (runMuation, result) {
                                  if (bankcardsdeletelist.isNotEmpty) {
                                    runMuation({'ids': bankcardsdeletelist});
                                  }
                                  return Container();
                                },
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              )
            // ignore: avoid_unnecessary_containers
            : Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 150),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1c1527),
                    borderRadius: BorderRadius.circular(23),

                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      // ignore: prefer_const_constructors
                      BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.black,
                          blurRadius: 4),
                    ],
                  ),
                  child: InkWell(
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Welcome to Card Accumulator app!\nIn This app you can hold your various\nGovernment ID's and Bank Cards in a \ncommon place for ease.Your card \nnumber will be will be well encrypted.\nFeel free to use the various features \nit offers at your ease\n\n\t\t\t\t\t\t\t\t\t\t\t\t Oops!No Holders found.\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAdd Holder",
                                  style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.0,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  String removeholder() {
    return """
      mutation RemoveHolder(\$id:String!){
        RemoveHolder(id:\$id){
          name
        }
      }
    """;
  }

  String removeIdcard() {
    return """
      mutation removeIdcards(\$ids:[String]){
        removeIdcards(ids:\$ids){

        }
      }
  """;
  }

  String removeBankcards() {
    return """
      mutation removeBankcards(\$ids:[String]){
        removeBankcards(ids:\$ids){
          
        }
      }
  """;
  }
}
