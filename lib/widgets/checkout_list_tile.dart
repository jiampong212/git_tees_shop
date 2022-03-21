import 'package:flutter/material.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';

class CheckoutListTile extends StatelessWidget {
  const CheckoutListTile({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 15,
            child: productNames.contains(product.tshirts.productName) ? Image.asset(
              'assets/${product.tshirts.productName}.jpeg',
            ) : Image.asset('1.jpg'),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.tshirts.priceStringPHP,
                    ),
                    Text('x${product.cartQuantity}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
