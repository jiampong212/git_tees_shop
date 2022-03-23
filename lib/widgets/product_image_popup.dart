import 'package:flutter/material.dart';

class ProductImagePopup extends StatelessWidget {
  const ProductImagePopup({Key? key, required this.productImage, required this.heroTag}) : super(key: key);

  final Image productImage;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: heroTag,
        child: productImage,
      ),
    );
  }
}
