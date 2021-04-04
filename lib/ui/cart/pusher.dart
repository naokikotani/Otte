import 'package:flutter/material.dart';
import 'package:otte/ui/cart/cartPage.dart';

class CartPagePusher {
  const CartPagePusher(this._context, {this.key});
  final BuildContext _context;
  final Key key;

  void push() {
    Navigator.of(_context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: 'CartPage'),
        builder: (context) => Cartpage(),
      ),
    );
  }
}