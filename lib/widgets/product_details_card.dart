import 'package:flutter/material.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';

class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({Key? key, required this.product}) : super(key: key);

  final Tshirts product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 2 / 3,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/bg1.png',
                width: MediaQuery.of(context).size.width * 2 / 5,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                product.productName,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                product.size,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                product.color,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                product.priceStringPHP,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Scan again'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add to cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
