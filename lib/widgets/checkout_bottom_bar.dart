import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/database_api.dart';
import 'package:git_tees_shop/core/pdf_utils.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';

class CheckoutBottomBar extends ConsumerWidget {
  const CheckoutBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
        ),
      ),
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: _totalDisplay(ref),
          ),
          _checkoutButton(context, ref),
        ],
      ),
    );
  }

  InkWell _checkoutButton(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await DatabaseAPI().orderProductsUsingRESTApi(ref.read(checkoutProvider));

        double _progress = 0;
        Timer? _timer;

        _timer?.cancel();
        _timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (Timer timer) async {
            EasyLoading.showProgress(_progress, status: '${(_progress * 100).toStringAsFixed(0)}%\nPurchase successful\nGenerating receipt...');
            _progress += 0.03;

            if (_progress >= 1) {
              List<CartProduct> _productList = await ref.read(checkoutProvider);
              double _total = await ref.read(totalPriceProvider);
              double _discount = Utils.calculateDiscount(
                selectedVoucher: ref.watch(selectedVoucherProvider),
                totalPrice: _total,
              );

              _timer?.cancel();
              await PDFUtils.openReceipt(
                await PDFUtils.generateReceipt(
                  _productList,
                  _total,
                  _discount,
                  ref.read(paymentMethodProvider),
                ),
              );

              await EasyLoading.dismiss();

              Navigator.pop(context);
              ref.read(selectedVoucherProvider.state).state = null;
              await ref.read(selectedProvider.notifier).clearSelected();
              await ref.read(cartProvider.notifier).clearCart();
            }
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        padding: const EdgeInsets.all(16),
        color: Colors.blue,
        child: const Center(
          child: Text('Order'),
        ),
      ),
    );
  }

  Padding _totalDisplay(WidgetRef ref) {
    double _total = ref.watch(totalPriceProvider);

    double _discount = Utils.calculateDiscount(
      selectedVoucher: ref.watch(selectedVoucherProvider),
      totalPrice: _total,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: 'total',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 12),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                Utils.formatToPHPString(_total - _discount),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
