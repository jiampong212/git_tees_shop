import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';

class CartProductProvider extends StateNotifier<List<CartProduct>> {
  CartProductProvider() : super([]);

  Future addProductToCart(CartProduct productToCart) async {
    if (_checkForDuplicates(productToCart).isNotEmpty) {
      increaseProductQuantity(productToCart);
    } else {
      List<CartProduct> _temp = state;
      _temp.add(productToCart);

      state = _temp.toList();
    }
  }

  Iterable<CartProduct> _checkForDuplicates(CartProduct productToCart) {
    Iterable<CartProduct> duplicates = state.where((element) {
      return element.tshirts.productID == productToCart.tshirts.productID;
    });

    return duplicates;
  }

  increaseProductQuantity(CartProduct productToCart) {
    for (var element in state) {
      if (element.tshirts.productID == productToCart.tshirts.productID) {
        element.cartQuantity++;
      }
    }

    state = state.toList();
  }

  decreaseProductQuantity(CartProduct productToCart) {
    for (var cartProduct in state) {
      if (cartProduct.tshirts.productID == productToCart.tshirts.productID) {
        if (cartProduct.cartQuantity == 1) {
          removeProductFromCart(cartProduct);
          return;
        }

        cartProduct.cartQuantity--;
      }
    }

    state = state.toList();
  }

  removeProductFromCart(CartProduct cartProduct) {
    state.remove(cartProduct);

    state = state.toList();
  }
}
