import 'dart:io';

import 'package:framework_e_commerce/data/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class GetXShopPresenter extends GetxController {
  final List<Product> products;

  GetXShopPresenter({required this.products});

  int calculateTotalPrice(Product product) {
    return product.price;
  }

  double calculateTotalPrices() {
    double total = 0.0;
    for (var product in products) {
      total += product.price;
    }
    return total;
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    // final ttf = Font.ttf(font);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Detalhes da Compra',
            ),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File('${directory.path}/purchase_details.pdf');
    await pdfFile.writeAsBytes(await pdf.save());
  }
}
