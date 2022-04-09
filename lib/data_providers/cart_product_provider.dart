import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/database_api.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';

class CartProductProvider extends StateNotifier<List<CartProduct>> {
  CartProductProvider() : super([]);

  Future scanProduct(String productID) async {

    CartProduct productToCart = CartProduct.empty();

    try {
      Tshirts _tshirt = await DatabaseAPI().addToCartUsingRESTApi(productID.trim());

      productToCart = CartProduct(
        cartQuantity: 1,
        tshirts: _tshirt,
      );
    } catch (e) {
      if (e.toString() == 'Bad state: No element') {
        return Future.error('Product does not exist');
      } else {
        debugPrint(e.toString());
        return Future.error('error here ' + e.toString());
      }
    }

    if (productToCart.tshirts.quantity == 0) {
      return Future.error('No stock left of\n${productToCart.tshirts.productName} - ${productToCart.tshirts.size} - ${productToCart.tshirts.color} ');
    }

    Iterable<CartProduct> _duplicates = _checkForDuplicates(productToCart);

    if (_duplicates.isNotEmpty) {
      return increaseProductQuantity(_duplicates.first);
    } else {
      _addToCart(productToCart);
    }
  }

  _addToCart(CartProduct productToCart) {
    List<CartProduct> _temp = state;
    _temp.add(productToCart);

    state = _temp.toList();
  }

  Iterable<CartProduct> _checkForDuplicates(CartProduct productToCart) {
    Iterable<CartProduct> duplicates = state.where((element) {
      return element.tshirts.productID == productToCart.tshirts.productID;
    });

    return duplicates;
  }

  increaseProductQuantity(CartProduct productToCart) {
    if (productToCart.cartQuantity >= productToCart.tshirts.quantity) {
      EasyLoading.showError('No stock left');
      return Future.error('No stock left');
    }

    for (var element in state) {
      if (element.tshirts.productID == productToCart.tshirts.productID) {
        element.cartQuantity++;
      }
    }

    state = state.toList();
  }

  decreaseProductQuantity(CartProduct productToCart, WidgetRef ref) {
    for (var cartProduct in state) {
      if (cartProduct.tshirts.productID == productToCart.tshirts.productID) {
        if (cartProduct.cartQuantity == 1) {
          removeProductFromCart(cartProduct, ref);
          return;
        }

        cartProduct.cartQuantity--;
      }
    }

    state = state.toList();
  }

  removeProductFromCart(CartProduct cartProduct, WidgetRef ref) {
    state.remove(cartProduct);

    ref.read(selectedProvider.notifier).removeFromSelected(cartProduct.tshirts.productID);

    state = state.toList();
  }

  clearCart() {
    state = [];
  }
}
