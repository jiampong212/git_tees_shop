import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';

class QuantityToggle extends ConsumerWidget {
  const QuantityToggle({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).increaseProductQuantity(product);
            },
            child: const Text('+')),
        Text(
          product.cartQuantity.toString(),
        ),
        TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).decreaseProductQuantity(product, ref);
            },
            child: const Text('-')),
      ],
    );
  }
}
