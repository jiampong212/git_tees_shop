// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TshirtSizeEnum {
  XS,
  S,
  M,
  L,
  XL,
}

enum TshirtColorsEnum {
  Black,
  White,
  Gray,
  Red,
  Orange,
  Yellow,
  Green,
  Blue,
  Violet,
  Maroon,
  Pink,
}

enum TableFieldsEnum {
  color,
  size,
  price,
  last_release_date,
  last_receive_date,
  product_id,
  quantity,
  product_name,
}

class Utils {
  static String formatToPHPString(double price) {
    NumberFormat _toPHPString = NumberFormat("###.00#", "en_US");

    return '₱ ${_toPHPString.format(price)}';
  }

  static String formatToString(double price) {
    NumberFormat _toPHPString = NumberFormat("###.00#", "en_US");

    return _toPHPString.format(price);
  }

  static String dateTimeToString(DateTime _dateTime) {
    return '${DateFormat.EEEE().format(_dateTime)} ${DateFormat.yMMMd().format(_dateTime)} ${DateFormat.jm().format(_dateTime)}';
  }

  static double homeScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight;
  }

  static double scanScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top;
  }
}
