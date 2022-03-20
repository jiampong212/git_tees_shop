import 'package:flutter/material.dart';
import 'package:git_tees_shop/core/utilites.dart';

class StoreInfoTile extends StatelessWidget {
  const StoreInfoTile({Key? key}) : super(key: key);

  static const String _shopNumber = '09494943017';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Utils.openStoreLocation();
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.my_location),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Git`Tees Lapaz',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('02-024 Jocson Drive, Jereos Street'),
                    const Text('Lapaz, Iloilo City, Iloilo, 5000'),
                    TextButton.icon(
                      icon: const Icon(Icons.phone),
                      label: const Text(_shopNumber),
                      onPressed: () async {
                        await Utils.callShopNumber(_shopNumber);
                      },
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
