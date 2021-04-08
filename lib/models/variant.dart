class Variant {
  const Variant({this.id, this.imageUrl, this.price, this.productType});

  factory Variant.fromJson(Map<String, dynamic> parsedJson) {
    return Variant(
      id: parsedJson['variants']['edges'][0]
          ['node']['id'] as String,
      imageUrl: parsedJson[''] as String ?? 'https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-1-580x440.png',
      productType: parsedJson['variants']
          ['edges'][0]['node']['title'] as String,
      price: parsedJson['variants']['edges'][0]
          ['node']['price'] as String,
    );
  }

  final String price;
  final String id;
  final String imageUrl;
  final String productType;
}
