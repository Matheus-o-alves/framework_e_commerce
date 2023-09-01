class ProductEntity {
  final String? name;
  // final String? kg;
  final String? id;
  final int? price;

  List get props => [name, id, price];

  const ProductEntity(
      {this.name,
      // this.kg,
      this.id,
      this.price});
}
