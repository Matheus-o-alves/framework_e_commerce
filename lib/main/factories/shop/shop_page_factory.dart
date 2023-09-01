import 'package:framework_e_commerce/data/models/product_model.dart';
import 'package:framework_e_commerce/ui/pages/shop/shop_page.dart';

ShopPage makeShopPage(List<Product> products) {
  return ShopPage(arguments: products);
}
