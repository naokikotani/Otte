import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/models/product.dart';
import 'package:otte/repositories/productRepository.dart';

final topPageViewModelProvider =
    AutoDisposeChangeNotifierProvider((ref) => TopPageViewModelProvider());

class TopPageViewModelProvider extends ChangeNotifier {
  TopPageViewModelProvider() {
    getProducts();
  }

  ProductRepository get _productRepository => const ProductRepository();

  List<Product> products = [];

  List<Product> get latestPosts => products;

  Future<void> getProducts() async {
    final productList = await _productRepository.getProducts(3);
    products = productList;
    notifyListeners();
  }
}
