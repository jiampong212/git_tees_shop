import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/screens/scan_page.dart';
import 'package:git_tees_shop/widgets/purchase_list_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CartProduct> _cartList = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Git`Tees Shop'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ScanPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.add_shopping_cart_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Add to cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Visibility(
            visible: _cartList.isNotEmpty,
            replacement: SizedBox(
              height: Utils.homeScreenHeight(context),
              child: const Center(
                child: Text('Empty Cart'),
              ),
            ),
            child: SizedBox(
              height: Utils.homeScreenHeight(context),
              child: ListView.builder(
                itemCount: _cartList.length,
                itemBuilder: (context, index) {
                  return PurchaseListTile(product: _cartList[index]);
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: kBottomNavigationBarHeight,
        color: Colors.blue,
      ),
    );
  }
}
