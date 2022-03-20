import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends ConsumerWidget {
  const ScanPage({Key? key}) : super(key: key);

  static final TextEditingController _manualScanController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _scanner(context, ref),
          _manualScan(context, ref),
        ],
      ),
    );
  }

  Visibility _scanner(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: SizedBox(
        height: Utils.scanScreenHeight(context) * 2 / 3,
        child: MobileScanner(
          allowDuplicates: false,
          onDetect: (code, args) async {
            await _scanProduct(context, ref, code.rawValue);
          },
        ),
      ),
    );
  }

  SizedBox _manualScan(BuildContext context, WidgetRef ref) {
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    _scanProduct(context, ref, _manualScanController.text.trim());
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

  Future<void> _scanProduct(BuildContext context, WidgetRef ref, String? productID) async {
    try {
      await ref.read(cartProvider.notifier).scanProduct(productID!, ref);
      Navigator.pop(context);
      _manualScanController.clear();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
