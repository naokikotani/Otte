import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:otte/models/variant.dart';

class Product {
  Product({this.productId, this.productName, this.variant});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      productId: parsedJson['id'] as String,
      productName: parsedJson['title'] as String,
      variant: Variant.fromJson(parsedJson),
    );
  }

  final String productId;
  final String productName;
  Variant variant = Variant(
    id: '',
    imageUrl: '',
    productType: '',
    price: '',
  );
}
