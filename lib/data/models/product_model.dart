import '../../domain/entities/product_entity.dart';

class Product {
  final String name;
  final String id;
  final int price;

  Product({
    required this.name,
    required this.id,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        price: price,
      );
}
