import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 56) {
        setState(() => _physics = const BouncingScrollPhysics());
      } else {
        setState(() => _physics = const BouncingScrollPhysics());
      }
    });
  }

  List HolderData = [];
  String QUERY = """
      query{
          holders{
              name
              id
              profession
              age
              }
          }
  """;

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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            // ignore: prefer_const_constructors
                            BoxShadow(
                              offset: const Offset(0, 8),
                              color: Colors.black,
                              blurRadius: 10,
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
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Profession:${holder["profession"] ?? 'N/A'}",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Age:${holder["age"] ?? 'N/A'}",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4.0,
                        child: RawMaterialButton(
                          padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                          elevation: 4.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          onPressed: () => print('Add to cart'),
                        ),
                      ),
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
}
