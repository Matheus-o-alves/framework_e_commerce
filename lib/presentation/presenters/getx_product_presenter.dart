import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../../data/usecases/remote_product.dart';

class ProductListController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var products = <Product>[].obs;
  var isSynced = false.obs;
  var searchQuery = ''.obs;
  final _navigateTo = Rx<String?>(null);

  Stream<String?> get navigateToStream => _navigateTo.stream;

  Future<void> navigationHomePage(List<Product> products) async {
    _navigateTo.value = '/shop-page';
  }

  List<Product> shop = [];
  RemoteProductRequest request = RemoteProductRequest();

  @override
  void onInit() async {
    super.onInit();
    isSynced.value = false;
    syncProducts();
  }

  void addShop(Product product) {
    shop.add(product);
    Get.snackbar(
      'Produto Adicionado',
      '${product.name} foi adicionado ao carrinho!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void syncProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      List<Product> fetchedProducts = await request.fetchProducts();

      if (searchQuery.value.isNotEmpty) {
        fetchedProducts = fetchedProducts
            .where((product) => product.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
            .toList();
      }

      products.clear();
      products.addAll(fetchedProducts);
      isSynced.value = true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Erro inesperado: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
