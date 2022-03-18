import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:git_tees_shop/core/database_api.dart';

class EnterLocalIP extends StatelessWidget {
  const EnterLocalIP({Key? key}) : super(key: key);

  static final TextEditingController _localIPController = TextEditingController();
  static final TextEditingController _portController = TextEditingController();
  static final TextEditingController _userController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  static final TextEditingController _dbNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Enter Local IP and port to connect to database'),
          TextField(
            controller: _localIPController,
          ),
          TextField(
            controller: _portController,
          ),
          TextField(
            controller: _userController,
          ),
          TextField(
            controller: _passwordController,
          ),
          TextField(
            controller: _dbNameController,
          ),
          ElevatedButton(
            onPressed: () async {
              if (await DatabaseAPI(
                localIP: _localIPController.text.trim(),
                port: _portController.text.trim(),
                user: _userController.text.trim(),
                password: _passwordController.text.trim(),
                dbName: _dbNameController.text.trim(),
              ).checkForDatabaseConnection()) {
                EasyLoading.showInfo('Connected', dismissOnTap: true, duration: const Duration(seconds: 100));
              }
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}
