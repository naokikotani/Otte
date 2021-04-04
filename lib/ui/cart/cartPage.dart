import 'package:flutter/material.dart';

class Cartpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '買い物カゴ',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
