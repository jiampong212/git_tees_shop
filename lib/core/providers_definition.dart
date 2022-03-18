import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_providers/cart_product_provider.dart';

final cartProvider = StateNotifierProvider<CartProductProvider, List<CartProduct>>(
  (ref) {
    return CartProductProvider();
  },
);
