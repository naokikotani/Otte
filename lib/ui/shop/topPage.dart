import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otte/repositories/productRepository.dart';
import 'package:otte/ui/cart/cartPage.dart';
import 'package:otte/ui/cart/pusher.dart';
import 'package:otte/ui/shop/productDetail/pusher.dart';
import 'package:otte/ui/shop/viewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class TopPage extends HookWidget {
  const TopPage();
  @override
  Widget build(BuildContext context) {
    final topPageViewModel = riverpod.useProvider(topPageViewModelProvider);
    final products = topPageViewModel.products;
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
              onPressed: () {
                topPageViewModel.getProducts(5);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Column(
                  children: [
                    Text(
                      products[index].productName,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '￥${products[index].variant.price}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                onTap: () {
                  ProductDetailPagePusher(context, product: products[index])
                      .push();
                },
              ),
            );
          },
          itemCount: products.length,
        ),
      ),
    );
  }
}
