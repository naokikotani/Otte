import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/ui/cart/cartPage.dart';
import 'package:otte/ui/cart/pusher.dart';

class TopPage extends StatelessWidget {
  const TopPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Otte', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.black,
              ),
              onPressed: CartPagePusher(context).push,
            ),
          ],
        ),
      ),
    );
  }
}
