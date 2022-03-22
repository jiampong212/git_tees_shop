import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_providers/cart_product_provider.dart';
import 'package:git_tees_shop/data_providers/checkout_provider.dart';
import 'package:mysql1/mysql1.dart';

final cartProvider = StateNotifierProvider<CartProductProvider, List<CartProduct>>(
  (ref) {
    return CartProductProvider();
  },
);

final selectedProvider = StateNotifierProvider<SelectedProvider, List<String>>(
  (ref) {
    return SelectedProvider();
  },
);

final checkoutProvider = StateProvider<List<CartProduct>>((ref) {
  List<CartProduct> _cartProducts = ref.watch(cartProvider);

  List<String> _checkoutProducts = ref.watch(selectedProvider);

  return _cartProducts.where((element) {
    return _checkoutProducts.contains(element.tshirts.productID);
  }).toList();
});

final totalPriceProvider = StateProvider<double>(
  (ref) {
    List<CartProduct> _checkoutList = ref.watch(checkoutProvider);

    double _price = 0;

    for (var element in _checkoutList) {
      _price = _price + (element.cartQuantity * element.tshirts.price);
    }

    return _price;
  },
);
final totalProductQuantityProvider = StateProvider<int>((ref) {
  List<CartProduct> _checkoutList = ref.watch(checkoutProvider);

  int _quantity = 0;

  for (var element in _checkoutList) {
    _quantity = _quantity + element.cartQuantity;
  }

  return _quantity;
});

final cartAllSelectedProvider = StateProvider<bool>((ref) {
  List<CartProduct> _cartProducts = ref.watch(cartProvider);

  List<String> _selectedProducts = ref.watch(selectedProvider);

  if (_cartProducts.isEmpty && _selectedProducts.isEmpty) {
    return false;
  }

  if (_cartProducts.length == _selectedProducts.length) {
    return true;
  } else {
    return false;
  }
});

final databaseSettingsProvider = StateProvider<ConnectionSettings>((ref) {
  return ConnectionSettings();
});

final selectedVoucherProvider = StateProvider<int?>((ref) {
  return null;
});
