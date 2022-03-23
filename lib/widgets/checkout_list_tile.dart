import 'package:flutter/material.dart';
import 'package:git_tees_shop/core/custom_route.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/widgets/product_image_popup.dart';

class CheckoutListTile extends StatelessWidget {
  const CheckoutListTile({Key? key, required this.product}) : super(key: key);

  final CartProduct product;

  @override
  Widget build(BuildContext context) {
    Image _productImage =
        productNames.contains(product.tshirts.productName) ? Image.asset('assets/${product.tshirts.productName}.jpeg') : Image.asset('assets/1.jpg');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 15,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CustomRoute(
                    builder: (context) {
                      return ProductImagePopup(
                        productImage: _productImage,
                        heroTag: product.tshirts.productID,
                      );
                    },
                  ),
                );
              },
              child: Hero(
                tag: product.tshirts.productID,
                child: _productImage,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Hero(
              tag: product.tshirts.productID + product.tshirts.productName,
              child: SingleChildScrollView(
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
            ),
          ),
        ],
      ),
    );
  }
}
