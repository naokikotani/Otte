class Variant {
  const Variant({this.id, this.price, this.productType});

  factory Variant.fromJson(Map<String, dynamic> parsedJson) {
    return Variant(
      id: parsedJson['id'] as String ?? '',
      price: parsedJson['price'] as String ?? '',
      // imageUrl: parsedJson[''] as String ??
      //     'https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-1-580x440.png',
      productType: parsedJson['title'] as String ?? '',
    );
  }

  final String id;
  final String price;
  // final String imageUrl;
  final String productType;
}
