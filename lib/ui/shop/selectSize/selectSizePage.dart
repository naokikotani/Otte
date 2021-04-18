import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:otte/globalViewModel/checkoutViewModel.dart';
import 'package:otte/models/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;

class SelectSizePage extends HookWidget {
  SelectSizePage({@required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = riverpod.useProvider(checkoutViewModelProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('サイズを選択', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        product.variants[index].imageUrl,
                        height: 40,
                        width: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            product.variants[index].productType,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '￥${product.variants[index].price}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: const Text('カートへ追加'),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () {
                          checkoutViewModel.addToLineItems(product.variants[index].id);
                        },
                      ),
                    ],
                  ),
                  Divider(thickness: 3, color: Colors.grey)
                ],
              ),
            );
          },
          itemCount: product.variants.length,
        ),
      ),
    );
  }
}
