// ignore_for_file: prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors

import 'package:card_accumulator/screens/edit_holder_screen.dart';
import 'package:card_accumulator/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HoldersScreen extends StatefulWidget {
  const HoldersScreen({Key? key}) : super(key: key);

  @override
  _HoldersScreenState createState() => _HoldersScreenState();
}

class _HoldersScreenState extends State<HoldersScreen> {
  final _controller = ScrollController();
  ScrollPhysics _physics =
      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  List HolderData = [];
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

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(QUERY)),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const CircularProgressIndicator();
        }
        HolderData = result.data!["holders"];
        return (HolderData.isNotEmpty)
            ? ListView.builder(
                controller: _controller,
                physics: _physics,
                itemCount: HolderData.length,
                itemBuilder: (context, index) {
                  final holder = HolderData[index];
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
                              padding: EdgeInsets.all(9.0),
                              shape: CircleBorder(),
                              elevation: 14.0,
                              fillColor: Colors.grey.shade900,
                              child: Icon(
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
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreenState();
                                }), (route) => false);
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
                          : Container()
                    ],
                  );
                },
              )
            // ignore: avoid_unnecessary_containers
            : Container(
                child: Center(
                  child: Text(
                    "No holders found",
                    style: GoogleFonts.openSans(
                        color: Colors.grey.shade200,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
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
}

String removeIdcard() {
  return """
    mutation removeIdcards(\$ids:[String]){
      removeIdcards(ids:\$ids){
        
      }
    }
  """;

}
