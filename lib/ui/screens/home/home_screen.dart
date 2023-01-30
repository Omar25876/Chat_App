import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routName = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('chat'),
       ),
      body:  Container(color: Colors.cyan,),
    );
  }
}
