// ignore_for_file: file_names

import 'package:flutter_test/flutter_test.dart';
import 'package:framework_e_commerce/data/models/product_model.dart';
import 'package:framework_e_commerce/presentation/presenters/getx_product_presenter.dart';

void main() {
  late ProductListController controller;

  setUp(() {
    controller = ProductListController();
  });

  test('addShop adds a product to the shop list', () {
    final product = Product(id: '1', name: 'Banana', price: 10);
    controller.addShop(product);

    expect(controller.shop.length, 1);
    expect(controller.shop[0].id, '1');
    expect(controller.shop[0].name, 'Banana');
    expect(controller.shop[0].price, 10);
  });
}
