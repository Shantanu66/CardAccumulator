import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HoldersScreen extends StatefulWidget {
  const HoldersScreen({Key? key}) : super(key: key);

  @override
  _HoldersScreenState createState() => _HoldersScreenState();
}

class _HoldersScreenState extends State<HoldersScreen> {
  final _controller = ScrollController();
  ScrollPhysics _physics = const ClampingScrollPhysics();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 56 &&
          _controller.position.pixels >= 56) {
        setState(() => _physics = const ClampingScrollPhysics());
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
        return ListView.builder(
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
                        blurRadius: 15,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${holder["name"]}",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
