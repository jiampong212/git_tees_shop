import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/screens/home_page.dart';

void main() {
  runApp(const ProviderScope(child: GitTeesOnlineShop()));
}

class GitTeesOnlineShop extends StatelessWidget {
  const GitTeesOnlineShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const HomePage(),
    );
  }
}
