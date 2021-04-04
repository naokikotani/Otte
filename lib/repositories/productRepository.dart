import 'package:otte/models/product.dart';
import 'package:otte/resources/api/productAPI.dart';

class ProductRepository {
  const ProductRepository();

  ProductAPI get _productAPI => const ProductAPI();

  Future<List<Product>> getProducts() async {
    final snapshot = await _productAPI.getCollectionByTitle();
    final name = snapshot.data;
    print(name);
  }
}
