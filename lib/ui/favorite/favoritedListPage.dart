import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/ui/cart/pusher.dart';

class FavoritedListPage extends StatelessWidget {
  const FavoritedListPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'お気に入り',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
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
