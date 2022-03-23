import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/database_api.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/screens/home_page.dart';
import 'package:mysql1/mysql1.dart';

class EnterMysqlSettingsPage extends ConsumerWidget {
  const EnterMysqlSettingsPage({Key? key}) : super(key: key);

  static final TextEditingController _localIPController = TextEditingController();
  static final TextEditingController _portController = TextEditingController();
  static final TextEditingController _userController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  static final TextEditingController _dbNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Enter MySQL settings to connect to database',
              softWrap: true,
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'This is for testing purposes only',
              style: TextStyle(fontSize: 18),
              softWrap: true,
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Local IP'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _localIPController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Port'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true)],
                    controller: _portController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Username'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Password'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('Database name'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _dbNameController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
            ),
          ),
        ],
      ),
    );
  }
}
