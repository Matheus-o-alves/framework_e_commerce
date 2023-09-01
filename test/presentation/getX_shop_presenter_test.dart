// ignore_for_file: file_names

import 'package:flutter_test/flutter_test.dart';
import 'package:framework_e_commerce/data/models/product_model.dart';
import 'package:framework_e_commerce/presentation/presenters/getx_shop_page_presenter.dart';

void main() {
  late GetXShopPresenter presenter;

  final products = [
    Product(id: '1', name: 'Banana', price: 10),
    Product(id: '2', name: 'Apple', price: 20),
    Product(id: '3', name: 'Orange', price: 30),
  ];

  setUp(() {
    presenter = GetXShopPresenter(products: products);
  });

  test('calculateTotalPrice calculates the price correctly', () {
    final product = Product(id: '4', name: 'Pineapple', price: 15);
    final totalPrice = presenter.calculateTotalPrice(product);
    expect(totalPrice, 15);
  });

  test('calculateTotalPrices calculates the total prices correctly', () {
    final totalPrices = presenter.calculateTotalPrices();
    expect(totalPrices, 10 + 20 + 30);
  });
}
