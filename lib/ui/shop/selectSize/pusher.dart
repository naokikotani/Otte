import 'package:flutter/material.dart';
import 'package:otte/models/product.dart';
import 'package:otte/ui/shop/selectSize/selectSizePage.dart';

class SelectSizePagePusher {
  const SelectSizePagePusher(this._context, {@required this.product, this.key});
  final BuildContext _context;
  final Product product;
  final Key key;

  void push() {
    Navigator.of(_context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        settings: const RouteSettings(name: 'SelectSizePage'),
        builder: (context) => SelectSizePage(product: product,),
      ),
    );
  }
}
