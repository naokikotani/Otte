import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:otte/ui/cart/viewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class Cartpage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cartPageViewModel = riverpod.useProvider(cartPageViewModelProvider);
    final cartProducts = cartPageViewModel.products;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '買い物カゴ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Column(
                  children: [
                    // Image.network(products[index].variants[0].imageUrl),
                    Text(
                      cartProducts[index].productName,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '￥${cartProducts[index].variants[0].price}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: cartProducts.length,
        ),
      ),
    );
  }
}
