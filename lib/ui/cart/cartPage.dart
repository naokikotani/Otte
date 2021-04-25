import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:otte/globalViewModel/checkoutViewModel.dart';
import 'package:otte/models/checkout.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:otte/ui/checkoutWebView/pusher.dart';

class Cartpage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = riverpod.useProvider(checkoutViewModelProvider);
    final checkout = checkoutViewModel.checkout ?? Checkout();
    final lineItems = checkout.lineItems ?? [];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '買い物カゴ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: lineItems.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    lineItems[index].imageUrls[0],
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lineItems[index].title,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '￥${lineItems[index].price.toStringAsFixed(0)}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: lineItems.length,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey[300],
                    indent: 16,
                    endIndent: 16,
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('消費税'),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            '¥0',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('合計(税込)'),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            '¥${checkout.totalPrice.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        onPressed: () {
                          CheckoutWebViewPusher(
                            context,
                            url: checkout.webUrl,
                          ).push();
                        },
                        child: Text('購入手続きに進む'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(10)),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                child: Center(
                  child: Text(
                    '買い物カゴには何も追加されていません',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    );
  }
}
