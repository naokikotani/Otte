import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/models/product.dart';
import 'package:otte/ui/shop/productDetail/addCartButton.dart';

class ProductDetailPage extends HookWidget {
  const ProductDetailPage({@required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('商品詳細', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                product.productName,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '${product.variants[0].price}',
                style: TextStyle(fontSize: 15),
              ),
              AddCartButton(),
            ],
          ),
        ),
      ),
    );
  }
}
