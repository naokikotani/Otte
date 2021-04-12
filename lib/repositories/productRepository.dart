import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otte/models/product.dart';
import 'package:otte/resources/api/productAPI.dart';

class ProductRepository {
  const ProductRepository();

  ProductAPI get _productAPI => const ProductAPI();

  Future<List<Product>> getProducts(int amount) async {
    final queryResult = await _productAPI.getProducts(amount);
    final productQueryList = queryResult.data['products']['edges'] as List;
    final productList = productQueryList.map<Product>((dynamic productData) {
      final node = productData['node'] as Map<String, dynamic>;
      return Product.fromJson(node);
    }).toList();

    return productList;
  }
}
