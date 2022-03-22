import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/database_api.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:mysql1/mysql1.dart';

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
        ConnectionSettings _settings = ref.read(databaseSettingsProvider);
        await DatabaseAPI(settings: _settings).orderProducts(ref.read(checkoutProvider));

        ref.read(selectedProvider.notifier).clearSelected();
        ref.read(cartProvider.notifier).clearCart();

        Navigator.pop(context);
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Total Payment:',
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
    );
  }
}
