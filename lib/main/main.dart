import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:framework_e_commerce/firebase_options.dart';
import 'package:framework_e_commerce/utils/app_translations.dart';
import 'package:get/get.dart';

import 'factories/login/login_page_factory.dart';
import 'factories/product/product_page_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Framework E-Commerce',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('pt', 'BR'),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeLoginPage,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/product-list-page',
          page: makeProductListPage,
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
