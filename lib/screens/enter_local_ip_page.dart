import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/database_api.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/screens/home_page.dart';
import 'package:mysql1/mysql1.dart';

class EnterLocalIP extends ConsumerWidget {
  const EnterLocalIP({Key? key}) : super(key: key);

  static final TextEditingController _localIPController = TextEditingController();
  static final TextEditingController _portController = TextEditingController();
  static final TextEditingController _userController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  static final TextEditingController _dbNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ConnectionSettings _settings = ConnectionSettings(
                host: _localIPController.text.trim(),
                port: int.parse(_portController.text.trim()),
                user: _userController.text.trim(),
                password: _passwordController.text.trim(),
                db: _dbNameController.text.trim(),
              );

              if (await DatabaseAPI(settings: _settings).checkForDatabaseConnection()) {
                ref.read(databaseSettingsProvider.state).state = _settings;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              } else {
                EasyLoading.showError('Failed to connect to database');
              }
            },
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}
