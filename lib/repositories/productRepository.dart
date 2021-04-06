import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otte/models/product.dart';
import 'package:otte/resources/api/productAPI.dart';

class ProductRepository {
  const ProductRepository();

  ProductAPI get _productAPI => const ProductAPI();

  Future<List<Product>> getProducts() async {
    final snapshot = await _productAPI.getProducts(5);
    List<Product> list = [];
    Map<String, dynamic> decoded = json.decode(snapshot.data);
    print(decoded);
    for (var item in decoded['id']) {
      list.add(Product.fromJson(item));
    }
    return list;
  }
}
