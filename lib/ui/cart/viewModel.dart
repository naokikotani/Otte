import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/models/product.dart';

final cartPageViewModelProvider =
    AutoDisposeChangeNotifierProvider((ref) => CartPageViewModelProvider());

class CartPageViewModelProvider extends ChangeNotifier {
  List<Product> products = [];

  List<Product> get cartProducts => products;
}
