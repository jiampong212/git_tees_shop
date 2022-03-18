import 'package:flutter/material.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';

class QuantityToggle extends StatelessWidget {
  const QuantityToggle({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(onPressed: () {}, child: const Text('+')),
        Text(product.cartQuantity.toString()),
        TextButton(onPressed: () {}, child: const Text('-')),
      ],
    );
  }
}
