import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/core/custom_route.dart';
import 'package:git_tees_shop/core/test_database_api.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';
import 'package:git_tees_shop/widgets/product_details_card.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  static final TextEditingController _manualScanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: SizedBox(
              height: Utils.scanScreenHeight(context) * 2 / 3,
              child: _scanner(context),
            ),
          ),
          _manualScan(context)
        ],
      ),
    );
  }

  SizedBox _manualScan(BuildContext context) {
    return SizedBox(
      height: Utils.scanScreenHeight(context) / 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Trouble scanning QR code?'),
            const Text('Enter product ID manually.'),
            Expanded(
              flex: 1,
              child: Center(
                child: TextField(
                  controller: _manualScanController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    _scanProduct(context, _manualScanController.text.trim());
                    _manualScanController.clear();
                  },
                  child: const Text('Enter'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MobileScanner _scanner(BuildContext context) {
    return MobileScanner(
      allowDuplicates: false,
      onDetect: (code, args) async {
        _scanProduct(context, code.rawValue);
      },
    );
  }

  Future _scanProduct(BuildContext context, String? productID) async {
    try {
      CartProduct productToCart = CartProduct(
        cartQuantity: 1,
        tshirts: await TestDatabaseAPI().testAddToCart(productID!),
      );

      if (productToCart.tshirts == Tshirts.empty()) {
        return Future.error('Product does not exist');
      }

      Navigator.push(
        context,
        CustomRoute(
          builder: (context) {
            return ProductDetailsCard(product: productToCart.tshirts);
          },
        ),
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
