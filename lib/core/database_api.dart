import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mysql1/mysql1.dart';

class DatabaseAPI {
  DatabaseAPI({
    required this.localIP,
    required this.port,
    required this.user,
    required this.password,
    required this.dbName,
  });

  String localIP;
  String port;
  String user;
  String password;
  String dbName;

  //String tableName = 'tshirt_inventory';
  //String dbName = 'cpe_211';

  late final ConnectionSettings settings = ConnectionSettings(
    host: localIP,
    port: int.parse(port),
    user: user,
    password: password,
    db: dbName,
  );

  Future<bool> checkForDatabaseConnection() async {
    EasyLoading.show();

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      EasyLoading.dismiss();

      await conn.close();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError(e.toString(), duration: const Duration(seconds: 10));
      return false;
    }
  }

  Future test() async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);

      Iterable results = await conn.query('SELECT * FROM `employee` WHERE 1', []);

      debugPrint(results.toString());

      EasyLoading.dismiss();

      await conn.close();
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Failed to connect to database');
    }
  }
}
