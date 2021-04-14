import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otte/models/variant.dart';

class Product {
  Product({this.productId, this.productName, this.variants});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    final productQueryList = parsedJson['variants']['edges'] as List;
    return Product(
      productId: parsedJson['id'] as String,
      productName: parsedJson['title'] as String,
      variants: productQueryList.map<Variant>((dynamic variant) {
        final node = variant['node'] as Map<String, dynamic>;
        return Variant.fromJson(node);
      }).toList(),
    );
  }

  final String productId;
  final String productName;
  final List<Variant> variants;
}
