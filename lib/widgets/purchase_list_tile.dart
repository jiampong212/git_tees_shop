import 'package:flutter/material.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/widgets/quantity_toggle.dart';

class PurchaseListTile extends StatelessWidget {
  const PurchaseListTile({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Checkbox(
            value: false,
            onChanged: (_) {},
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/bg1.png',
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Text(
                product.tshirts.productName,
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.tshirts.size,
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    product.tshirts.color,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.tshirts.priceStringPHP,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: QuantityToggle(
            product: product,
          ),
        )
      ],
    );
  }
}
