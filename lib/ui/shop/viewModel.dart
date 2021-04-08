import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/models/product.dart';
import 'package:otte/repositories/productRepository.dart';

final topPageViewModelProvider =
    AutoDisposeChangeNotifierProvider((ref) => TopPageViewModelProvider());

class TopPageViewModelProvider extends ChangeNotifier {
  ProductListPageViewModel(int amount) {
    _initialize(amount);
  }
  ProductRepository get _productRepository => const ProductRepository();

  List<Product> products = [];

  List<Product> get latestPosts => products;

  void _initialize(int amount) {
    getProducts(amount);
  }

  Future<void> getProducts(int amount) async {
    final productList = await _productRepository.getProducts(amount);
    products = productList;
  }
}
