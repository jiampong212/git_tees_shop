import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';
import 'package:http/http.dart' as http;

class DatabaseAPI {
  DatabaseAPI();

  Future<Tshirts> addToCartUsingRESTApi(String productID) async {
    EasyLoading.show(status: 'Loading');

    String _embedURL = 'http://10.0.2.2:3000/$productID';

    try {
      http.Response response = await http.get(Uri.parse(_embedURL));

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
        return Tshirts.fromJson(response.body);
      } else {
        return Future.error('Error here');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future orderProductsUsingRESTApi(List<CartProduct> _orders) async {
    EasyLoading.show(status: 'Loading');

    String _embedURL = 'http://10.0.2.2:3000/order';

    try {
      http.Response response = await http.post(
        Uri.parse(_embedURL),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(_orders),
      );

      if (response.statusCode == 200) {
        await EasyLoading.dismiss();
      } else {
        return Future.error('Failed to order product');
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
