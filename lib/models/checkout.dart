import 'package:flutter/material.dart';
import 'package:otte/models/mailingAdress.dart';

class Checkout {
  const Checkout({
    @required this.id,
    @required this.webUrl,
    @required this.email,
    @required this.totalPrice,
    @required this.mailingAddress,
    @required this.lineItems,
  });

  factory Checkout.fromQueryResult(Map<String, dynamic> checkout) {
    final edges = checkout['lineItems']['edges'] as List;
    final lineItems = edges
            .map(
              (dynamic map) => LineItem.fromMapInQuerySnapshot(
                map['node']['id'],
                map['node']['quantity'],
                map['node']['variant']['product'],
              ),
            )
            .toList() ??
        [];
    final shippingAddress =
        checkout['shippingAddress'] as Map<String, dynamic> ??
            <String, dynamic>{
              'id': null,
              'address1': null,
              'address2': null,
              'city': null,
              'country': null,
              'firstName': null,
              'lastName': null,
              'phone': null,
              'province': null,
              'zip': null,
            };
    final mailingAddress = MailingAddress(
      id: shippingAddress['id'] as String ?? '',
      address1: shippingAddress['address1'] as String ?? '',
      address2: shippingAddress['address2'] as String ?? '',
      city: shippingAddress['city'] as String ?? '',
      country: shippingAddress['country'] as String ?? '',
      firstName: shippingAddress['firstName'] as String ?? '',
      lastName: shippingAddress['lastName'] as String ?? '',
      phone: shippingAddress['phone'] as String ?? '',
      province: shippingAddress['province'] as String ?? '',
      zip: shippingAddress['zip'] as String ?? '',
    );
    return Checkout(
      id: checkout['id'] as String ?? '',
      webUrl: checkout['webUrl'] as String ?? '',
      email: checkout['email'] as String ?? '',
      totalPrice:
          double.parse(checkout['totalPrice'].toString(), (_) => 0.0) ?? 0,
      // totalPrice: (checkout['totalPrice'] ?? 0.0) as double,
      mailingAddress: mailingAddress,
      lineItems: lineItems,
    );
  }

  final String id;
  final String webUrl;
  final String email;
  final double totalPrice;
  final MailingAddress mailingAddress;
  final List<LineItem> lineItems;
}

class LineItem {
  const LineItem({
    @required this.id,
    @required this.quantity,
    @required this.productId,
    @required this.variantId,
    @required this.title,
    @required this.vendor,
    @required this.productType,
    @required this.imageUrls,
    @required this.price,
    @required this.tags,
  });

  factory LineItem.fromMapInQuerySnapshot(
    String id,
    int quantity,
    Map<String, dynamic> productMap,
  ) {
    final queryImages = productMap['images']['edges'] as List;
    final imageUrls = queryImages
            .map<String>((dynamic image) => image['node']['src'] as String)
            .toList() ??
        [];
    return LineItem(
      id: id,
      quantity: quantity,
      productId: productMap['id'] as String ?? '',
      variantId: productMap['variants'] != null
          ? productMap['variants']['edges'][0]['node']['id'] as String ?? ''
          : '',
      title: productMap['title'] as String ?? '',
      vendor: productMap['vendor'] as String ?? '',
      productType: productMap['productType'] as String ?? '',
      price: double.parse(
        productMap['priceRange']['maxVariantPrice']['amount'].toString(),
        (_) => 0.0,
      ),
      imageUrls: imageUrls,
      tags: productMap['tags']?.cast<String>(),
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'quantity': quantity,
        'productId': productId,
        'variantId': variantId,
        'title': title,
        'vendor': vendor,
        'imageUrls': imageUrls,
        'productType': productType,
        'price': price,
        'tags': tags,
      };

  final String id;
  final int quantity;
  final String productId;
  final String variantId;
  final String title;
  final String vendor;
  final List<String> imageUrls;
  final String productType;
  final double price;
  final List<String> tags;
}
