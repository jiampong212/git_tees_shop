import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/screens/checkout_page.dart';

class HomeBottomBar extends ConsumerWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _isAllSelected = ref.watch(cartAllSelectedProvider);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
        ),
      ),
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _checkAllBox(_isAllSelected, ref),
          const Text(
            'All',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 10,
          ),
          _deleteIcon(ref),
          Expanded(child: Container()),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: _totalDisplay(ref),
          ),
          _checkoutButton(context, ref),
        ],
      ),
    );
  }

  Checkbox _checkAllBox(bool _isAllSelected, WidgetRef ref) {
    return Checkbox(
      value: _isAllSelected,
      onChanged: (value) {
        if (_isAllSelected) {
          ref.read(selectedProvider.notifier).clearSelected();
        } else {
          ref.read(cartProvider).forEach(
            (element) {
              ref.read(selectedProvider.notifier).addToSelected(element.tshirts.productID);
            },
          );
        }
      },
    );
  }

  InkWell _checkoutButton(BuildContext context, WidgetRef ref) {
    String _quantityString = ref.read(totalProductQuantityProvider).toString();

    return InkWell(
      onTap: ref.watch(selectedProvider).isEmpty
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CheckoutPage();
                  },
                ),
              );
            },
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.blue,
        child: Center(
          child: Text('Check Out ($_quantityString)'),
        ),
      ),
    );
  }

  IconButton _deleteIcon(WidgetRef ref) {
    return IconButton(
      onPressed: ref.watch(selectedProvider).isEmpty
          ? null
          : () {
              List<CartProduct> _checkoutList = ref.read(checkoutProvider);

              for (var element in _checkoutList) {
                ref.read(cartProvider.notifier).removeProductFromCart(element, ref);
              }
            },
      icon: const Icon(Icons.delete),
    );
  }

  Padding _totalDisplay(WidgetRef ref) {
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
                Utils.formatToPHPString(ref.watch(totalPriceProvider)),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
