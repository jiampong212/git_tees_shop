import 'dart:convert';

import 'package:git_tees_shop/core/utilites.dart';

class Tshirts {
  final String color;
  final String size;
  final double price;
  final DateTime? lastDateReleased;
  final DateTime? lastDateReceived;
  final String productID;
  final int quantity;
  final String productName;

  late String priceStringPHP;
  late String lastDateReleasedString;
  late String lastDateReceivedString;
  Tshirts({
    required this.quantity,
    required this.color,
    required this.size,
    required this.price,
    required this.lastDateReleased,
    required this.lastDateReceived,
    required this.productID,
    required this.productName,
  }) {
    priceStringPHP = Utils.formatToPHPString(price);

    if (lastDateReceived != null) {
      lastDateReceivedString = Utils.dateTimeToString(lastDateReceived!);
    } else {
      lastDateReceivedString = 'Not Specified';
    }

    if (lastDateReleased != null) {
      lastDateReleasedString = Utils.dateTimeToString(lastDateReleased!);
    } else {
      lastDateReleasedString = 'Not Specified';
    }
  }

  Tshirts.empty()
      : productID = '',
        quantity = 0,
        size = TshirtSizeEnum.M.name,
        color = TshirtColorsEnum.Black.name,
        lastDateReceived = null,
        lastDateReleased = null,
        price = 0,
        productName = '' {
    priceStringPHP = Utils.formatToPHPString(price);

    if (lastDateReceived != null) {
      lastDateReceivedString = Utils.dateTimeToString(lastDateReceived!);
    } else {
      lastDateReceivedString = 'Not Specified';
    }

    if (lastDateReleased != null) {
      lastDateReleasedString = Utils.dateTimeToString(lastDateReleased!);
    } else {
      lastDateReleasedString = 'Not Specified';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tshirts &&
        other.color == color &&
        other.size == size &&
        other.price == price &&
        other.lastDateReleased == lastDateReleased &&
        other.lastDateReceived == lastDateReceived &&
        other.productID == productID &&
        other.quantity == quantity &&
        other.productName == productName &&
        other.priceStringPHP == priceStringPHP &&
        other.lastDateReleasedString == lastDateReleasedString &&
        other.lastDateReceivedString == lastDateReceivedString;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        size.hashCode ^
        price.hashCode ^
        lastDateReleased.hashCode ^
        lastDateReceived.hashCode ^
        productID.hashCode ^
        quantity.hashCode ^
        productName.hashCode ^
        priceStringPHP.hashCode ^
        lastDateReleasedString.hashCode ^
        lastDateReceivedString.hashCode;
  }

  @override
  String toString() {
    return 'Tshirts(color: $color, size: $size, price: $price, lastDateReleased: $lastDateReleased, lastDateReceived: $lastDateReceived, productID: $productID, quantity: $quantity, productName: $productName, priceStringPHP: $priceStringPHP, lastDateReleasedString: $lastDateReleasedString, lastDateReceivedString: $lastDateReceivedString)';
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'size': size,
      'price': price,
      'lastDateReleased': lastDateReleased?.millisecondsSinceEpoch,
      'lastDateReceived': lastDateReceived?.millisecondsSinceEpoch,
      'productID': productID,
      'quantity': quantity,
      'productName': productName,
    };
  }

  factory Tshirts.fromMap(Map<String, dynamic> map) {
    return Tshirts(
      color: map['color'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      lastDateReleased: map['lastDateReleased'] != null ? DateTime.fromMillisecondsSinceEpoch(map['lastDateReleased']) : null,
      lastDateReceived: map['lastDateReceived'] != null ? DateTime.fromMillisecondsSinceEpoch(map['lastDateReceived']) : null,
      productID: map['product_id'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      productName: map['product_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tshirts.fromJson(String source) => Tshirts.fromMap(json.decode(source));
}
