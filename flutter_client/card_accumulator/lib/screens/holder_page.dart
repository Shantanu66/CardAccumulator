import 'package:flutter/material.dart';

class HoldersScreen extends StatefulWidget {
  const HoldersScreen({Key? key}) : super(key: key);

  @override
  _HoldersScreenState createState() => _HoldersScreenState();
}

class _HoldersScreenState extends State<HoldersScreen> {
  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels <= 56 &&
      _controller.position.pixels >= 56)
        setState(() => _physics = ClampingScrollPhysics());
      else
        setState(() => _physics = BouncingScrollPhysics());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      physics: _physics,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  bottom: 23, left: 10, right: 10, top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                /*boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    color: Colors.grey.shade300,
                    blurRadius: 30,
                  )
                ],*/
              ),
              padding: const EdgeInsets.all(20),
              child: InkWell(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [Text("Holder")],
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
  }
}
