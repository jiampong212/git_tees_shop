// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/data_classes/voucher_data.dart';
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

List<VoucherData> voucherData = [
  VoucherData(
    voucherID: 0,
    voucherTitle: '₱50 off when purchasing 5 or more shirts',
    voucherSubtitle: 'Minimum spend ₱500\nValid until April 30, 2022',
    leading: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '-₱50',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  ),
  VoucherData(
    voucherID: 1,
    voucherTitle: '₱100 off when purchasing 10 or more shirts',
    voucherSubtitle: 'Minimum spend ₱1000\nValid until April 30, 2022',
    leading: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '-₱100',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  ),
  VoucherData(
    voucherID: 2,
    voucherTitle: '₱300 off when purchasing 30 or more shirts',
    voucherSubtitle: 'Minimum spend ₱3000\nValid until April 30, 2022',
    leading: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '-₱300',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  ),
  VoucherData(
    voucherID: 3,
    voucherTitle: '10% off ',
    voucherSubtitle: 'Minimum spend ₱300 capped at ₱80\nExpiring: 10 hours left',
    leading: Container(
      child: const Center(
        child: Text(
          '-10%',
          style: TextStyle(fontSize: 18),
        ),
      ),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  VoucherData(
    voucherID: 4,
    voucherTitle: 'UTANG',
    voucherSubtitle: '100% off\nValid forever',
    leading: Container(
      child: const Center(
        child: Text(
          '-100%',
          style: TextStyle(fontSize: 15),
        ),
      ),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
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
    return '${DateFormat.EEEE().format(_dateTime)} ${DateFormat.yMMMMd().format(_dateTime)} ${DateFormat.jm().format(_dateTime)}';
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

  static double calculateDiscount({required int? selectedVoucher, required double totalPrice}) {
    switch (selectedVoucher) {
      case 0:
        return 50;
      case 1:
        return 100;
      case 2:
        return 300;
      case 3:
        double _discount = totalPrice / 10;

        if (_discount > 80) {
          return 80;
        } else {
          return _discount;
        }

      default:
        return 0;
    }
  }
}
