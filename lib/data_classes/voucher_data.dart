import 'package:flutter/material.dart';

class VoucherData {
  int voucherID;
  String voucherTitle;
  String voucherSubtitle;
  Widget leading;
  VoucherData({
    required this.voucherID,
    required this.voucherTitle,
    required this.voucherSubtitle,
    required this.leading,
  });
}
