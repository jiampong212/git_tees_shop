import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/data_classes/cart_product.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseAPI {
  DatabaseAPI({
    required this.settings,
  });

  String tableName = 'tshirt_inventory';

  final ConnectionSettings settings;

  Future<Tshirts> addToCart(String productID) async {
    EasyLoading.show(status: 'Loading');

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      //await Future.delayed(const Duration(seconds: 1));

      Iterable results = await conn.query('SELECT * FROM `$tableName` WHERE `product_id`=?', [productID]);

      await EasyLoading.dismiss();
      return Tshirts(
        color: results.first[0],
        size: results.first[1],
        price: results.first[2],
        lastDateReleased: results.first[3],
        lastDateReceived: results.first[4],
        productID: results.first[5],
        quantity: results.first[6],
        productName: results.first[7],
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> checkForDatabaseConnection() async {
    EasyLoading.show(status: 'Loading');

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      //  await Future.delayed(const Duration(seconds: 1));

      await conn.close();
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future orderProducts(List<CartProduct> _orders) async {
    EasyLoading.show(status: 'Loading');

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      //  await Future.delayed(const Duration(seconds: 1));
      for (var element in _orders) {
        int _newQuantity = element.tshirts.quantity - element.cartQuantity;

        await conn.query('UPDATE `$tableName` SET `quantity`=?, `last_release_date`=? WHERE `product_id`=?', [
          _newQuantity,
          DateTime.now().toUtc(),
          element.tshirts.productID,
        ]);
      }
      await conn.close();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
