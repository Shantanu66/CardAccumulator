import 'package:flutter/material.dart';

class EditIdcardScreen extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String cardnumber;
  final String DOB;
  const EditIdcardScreen({ Key? key ,
    required this.id,
    required this.title,
    required this.description,
    required this.cardnumber,
    required this.DOB,
  
  }) : super(key: key);

  @override
  _EditIdcardScreenState createState() => _EditIdcardScreenState();
}

class _EditIdcardScreenState extends State<EditIdcardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}