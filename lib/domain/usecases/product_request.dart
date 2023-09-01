import '../../data/models/product_model.dart';

abstract class ProductRequest {
  Future<List<Product>> fetchProducts();
}
