import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:otte/globalViewModel/checkoutViewModel.dart';
import 'package:otte/ui/cart/pusher.dart';
import 'package:otte/ui/cart/viewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:otte/ui/checkoutWebView/pusher.dart';

class Cartpage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final cartPageViewModel = riverpod.useProvider(cartPageViewModelProvider);
    final checkoutViewModel = riverpod.useProvider(checkoutViewModelProvider);
    final lineItem = checkoutViewModel.checkout.lineItems;
    final checkout = checkoutViewModel.checkout;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '買い物カゴ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.network(lineItem[index].imageUrls[0]),
                          Text(
                            lineItem[index].title,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '￥${lineItem[index].price}',
                            style: TextStyle(fontSize: 15),
                          ),
                          RaisedButton(
                              color: Colors.blue,
                              child: Text('削除する'),
                              onPressed: () {
                                checkoutViewModel
                                    .removeLineItem(lineItem[index].id);
                              })
                        ],
                      ),
                    ),
                  );
                },
                itemCount: lineItem.length,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                '合計金額 ${checkout.totalPrice}円',
                style: TextStyle(fontSize: 20),
              ),
            ),
            RaisedButton(
                color: Colors.orange,
                child: Text('購入手続きに進む'),
                onPressed: () {
                  CheckoutWebViewPusher(
                    context,
                    url: checkout.webUrl,
                  ).push();
                })
          ],
        ),
      ),
    );
  }
}
