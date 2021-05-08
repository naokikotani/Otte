import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          title: Text(
            'Otte',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.black,
              ),
              onPressed: () {
                CartPagePusher(context).push();
              },
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Column(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.network(
                        products[index].variants[0].imageUrl,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Text(
                    products[index].productName,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        '￥${products[index].variants[0].price}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                ProductDetailPagePusher(
                  context,
                  product: products[index],
                ).push();
              },
            ),
          ),
        ),
      ),
    );
  }
}
