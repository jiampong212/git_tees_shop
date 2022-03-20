import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';

class PurchaseDetails extends ConsumerWidget {
  const PurchaseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double _total = ref.watch(totalPriceProvider);
    double _vat = _total * 0.12;
    double _subtotal = _total * 0.88;
    double _discount = ref.watch(discountProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Product Subtotal'),
              Text(Utils.formatToPHPString(_subtotal)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Value Added Tax (12%)'),
              Text(Utils.formatToPHPString(_vat)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Git`Tee Voucher Discount'),
              Text('-${Utils.formatToPHPString(_discount)}'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Payment',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              Text(
                Utils.formatToPHPString(_total - _discount),
                style: const TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
