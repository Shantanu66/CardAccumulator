import 'package:flutter/material.dart';
import 'package:card_accumulator/splashscreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REALITY CONJURER',
      debugShowCheckedModeBanner: false,
      home:MySplash()
    );
  }
}
