import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/data_classes/tshirt.dart';
import 'package:mysql1/mysql1.dart';

class TestDatabaseAPI {
  String tableName = 'tshirt_inventory';
  String dbName = 'cpe_211';

  late final ConnectionSettings settings = ConnectionSettings(
    host: '192.168.1.12',
    port: 3306,
    user: 'angelo',
    password: 'krystelle12',
    db: dbName,
  );

  Future<Tshirts> testAddToCart(String productID) async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      Iterable results = await conn.query('SELECT * FROM `tshirt_inventory` WHERE `product_id`=?', [productID]);

      EasyLoading.dismiss();
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
      return Tshirts.empty();
    }
  }
}
