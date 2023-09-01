import 'package:flutter/material.dart';
import 'package:framework_e_commerce/ui/pages/product/components/card_product_widget.dart';
import 'package:framework_e_commerce/ui/pages/shop/shop_page.dart';
import 'package:get/get.dart';

import '../../../presentation/presenters/getx_product_presenter.dart';

class ProductListPage extends StatelessWidget {
  final controller = Get.put(ProductListController());

  ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Column(
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF5F3473),
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  'Framework Hortifruit',
                  style: TextStyle(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  controller.searchQuery.value = value;
                  controller.syncProducts();
                },
                decoration: InputDecoration(
                  labelText: 'search_products'.tr,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (!controller.isSynced.value) {
                  return const Text(
                    'Carregando',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5F3473),
                    ),
                  );
                } else if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (controller.hasError.value) {
                  return Text(
                    controller.errorMessage.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.addShop(controller.products[index]);
                          },
                          child: CardProductWidget(
                            controller: controller,
                            index: index,
                          ));
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => ShopPage(
              arguments: controller.shop,
            )),
        backgroundColor: const Color(0xFF5F3473),
        child: const Icon(Icons.sync),
      ),
    );
  }
}
