import 'package:flutter/material.dart';
import 'package:otte/models/product.dart';
import 'package:otte/ui/shop/productDetail/productDetailPage.dart';

class ProductDetailPagePusher {
  const ProductDetailPagePusher(this._context, {@required this.product});
  final BuildContext _context;
  final Product product;

  void push() {
    Navigator.of(_context).push<dynamic>(
      MaterialPageRoute<Widget>(
        settings: const RouteSettings(name: 'ProductDetail'),
        builder: (context) => ProductDetailPage(product: product,),
      ),
    );
  }
}
