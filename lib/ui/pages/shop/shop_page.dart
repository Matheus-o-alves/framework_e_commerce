import 'package:flutter/material.dart';
import 'package:framework_e_commerce/data/models/product_model.dart';
import 'package:framework_e_commerce/presentation/presenters/getx_shop_page_presenter.dart';
import 'package:get/get.dart';

class ShopPage extends StatelessWidget {
  final List<Product> arguments;

  const ShopPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetXShopPresenter(products: arguments));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF5F3473),
                  size: 40,
                ),
                const SizedBox(width: 10),
                Text(
                  'your_orders'.tr,
                  style: const TextStyle(
                    color: Color(0xFF5F3473),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      for (var product in controller.products)
                        Text(
                            '${product.name}: \$${controller.calculateTotalPrice(product).toStringAsFixed(2)}'),
                      const SizedBox(height: 16),
                      Text(
                          'Total: \$${controller.calculateTotalPrices().toStringAsFixed(2)}'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        controller.generatePDF();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5F3473),
                      ),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: Text('generate_invoice'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        backgroundColor: const Color(0xFF5F3473), // Cor do botão de voltar
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
