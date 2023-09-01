import 'package:flutter/material.dart';
import 'package:framework_e_commerce/presentation/presenters/getx_product_presenter.dart';

class CardProductWidget extends StatelessWidget {
  const CardProductWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final ProductListController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.shopping_basket,
                  color: Color(0xFF5F3473),
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  controller.products[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5F3473),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${controller.products[index].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5F3473),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF5F3473),
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
