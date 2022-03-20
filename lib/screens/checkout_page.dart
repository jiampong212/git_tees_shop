import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/widgets/checkout_bottom_bar.dart';
import 'package:git_tees_shop/widgets/checkout_list_tile.dart';
import 'package:git_tees_shop/widgets/mode_of_payment_tile.dart';
import 'package:git_tees_shop/widgets/purchase_details.dart';
import 'package:git_tees_shop/widgets/store_info_tile.dart';

class CheckoutPage extends ConsumerWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: ListView(
        children: [
          const StoreInfoTile(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Cart',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ..._checkoutList(ref),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          const ModeOfPaymentTile(),
          const Divider(),
          const PurchaseDetails(),
        ],
      ),
      bottomNavigationBar: const CheckoutBottomBar(),
    );
  }

  _checkoutList(WidgetRef ref) {
    List<CartProduct> _checkoutList = ref.watch(checkoutProvider);

    return _checkoutList.map(
      (product) {
        return CheckoutListTile(product: product);
      },
    );
  }
}
