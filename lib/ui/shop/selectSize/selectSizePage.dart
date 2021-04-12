import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSizePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('サイズを選択', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
