import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/models/product.dart';
import 'package:otte/ui/shop/selectSize/pusher.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.network(
                            product.variants[index].imageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      );
                    },
                    itemCount: product.variants.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: Text(
                    product.productName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    '¥${product.variants[0].price}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    SelectSizePagePusher(context, product: product).push();
                  },
                  child: Text('種類を選択して追加'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 18)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
