// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

List<String> productNames = [
  'Coder Life Shirt',
  'Git`Tees',
  'GitHub Programmer',
  'Programmer Jokes Shirt',
  'Programming Memes Shirt',
];

class Utils {
  static String formatToPHPString(double price) {
    NumberFormat _toPHPString = NumberFormat("##0.00", "en_US");

    return '₱ ${_toPHPString.format(price)}';
  }

  static String formatToString(double price) {
    NumberFormat _toPHPString = NumberFormat("##0.00", "en_US");

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

  static callShopNumber(String shopNumber) async {
    String error = 'Failed to call number';
    final Uri _launchURI = Uri(
      scheme: 'tel',
      path: shopNumber,
    );

    if (!await canLaunch(_launchURI.toString())) {
      EasyLoading.showError(error);
      return;
    }

    try {
      await launch(_launchURI.toString());
    } catch (e) {
      EasyLoading.showError(error);
      return;
    }
  }

  static openStoreLocation() async {
    String error = 'Failed to open store location';
    String _storeLocationURL = 'https://goo.gl/maps/J6SFT2xG3BLoBDJNA';

    if (!await canLaunch(_storeLocationURL)) {
      EasyLoading.showError(error);
      return;
    }

    try {
      await launch(_storeLocationURL);
    } catch (e) {
      EasyLoading.showError(error);
      return;
    }
  }
}
