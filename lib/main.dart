import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/screens/enter_mysql_settings_page.dart';

void main() {
  runApp(const ProviderScope(child: GitTeesOnlineShop()));
}

class GitTeesOnlineShop extends StatelessWidget {
  const GitTeesOnlineShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = Colors.blue
      ..indicatorColor = Colors.blue
      ..textColor = Colors.black
      ..backgroundColor = Colors.white
      ..userInteractions = false
      ..dismissOnTap = false
      ..errorWidget = const Icon(
        Icons.error,
        color: Colors.red,
      );

    return MaterialApp(
      theme: ThemeData.light().copyWith(dividerColor: Colors.black),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const EnterMysqlSettingsPage(),
    );
  }
}
