class Product {
  const Product({
    this.productId,
    this.productName,
    this.imageUrls,
    this.productType,
    this.price
  });

  final String productId;
  final String productName;
  final List<String> imageUrls;
  final String productType;
  final double price;
}