import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/models/product.dart';
import 'package:otte/repositories/productRepository.dart';

final topPageViewModelProvider =
    AutoDisposeChangeNotifierProvider((ref) => TopPageViewModelProvider());

class TopPageViewModelProvider extends ChangeNotifier {
  ProductRepository get _productRepository => const ProductRepository();

  List<Product> _products = [];

  List<Product> get latestPosts => _products;

  void getProducts() {
    _productRepository.getProducts().listen((products) {
      _products = products;
      notifyListeners();
    });
  }
}
