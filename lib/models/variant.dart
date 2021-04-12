class Variant {
  const Variant({this.id, this.price, this.imageUrl = '', this.productType});

  factory Variant.fromJson(Map<String, dynamic> parsedJson) {
    return Variant(
      id: parsedJson['id'] as String ?? '',
      price: parsedJson['price'] as String ?? '',
      imageUrl: parsedJson['image']['id'] as String ?? '',
      productType: parsedJson['title'] as String ?? '',
    );
  }

  final String id;
  final String price;
  final String imageUrl;
  final String productType;
}
