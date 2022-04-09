import 'dart:convert';

import 'package:git_tees_shop/data_classes/tshirt.dart';

class CartProduct {
  int cartQuantity;
  final Tshirts tshirts;
  CartProduct({
    required this.cartQuantity,
    required this.tshirts,
  });

  CartProduct.empty()
      : tshirts = Tshirts.empty(),
        cartQuantity = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProduct && other.cartQuantity == cartQuantity && other.tshirts == tshirts;
  }

  @override
  int get hashCode => cartQuantity.hashCode ^ tshirts.hashCode;

  @override
  String toString() => 'CartProduct(cartQuantity: $cartQuantity, tshirts: $tshirts)';

  CartProduct copyWith({
    int? cartQuantity,
    Tshirts? tshirts,
  }) {
    return CartProduct(
      cartQuantity: cartQuantity ?? this.cartQuantity,
      tshirts: tshirts ?? this.tshirts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartQuantity': cartQuantity,
      'tshirts': tshirts.toMap(),
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map) {
    return CartProduct(
      cartQuantity: map['cartQuantity']?.toInt() ?? 0,
      tshirts: Tshirts.fromMap(map['tshirts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source) => CartProduct.fromMap(json.decode(source));
}
