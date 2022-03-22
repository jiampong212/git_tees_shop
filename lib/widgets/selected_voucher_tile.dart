import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/voucher_data.dart';
import 'package:git_tees_shop/screens/select_voucher_screen.dart';

class SelectedVoucherTile extends ConsumerWidget {
  const SelectedVoucherTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SelectVoucherScreen();
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Git`Tee Voucher',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      int? _selectedVoucher = ref.watch(selectedVoucherProvider);

                      if (_selectedVoucher == null) {
                        return const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text('No voucher selected'),
                          ),
                        );
                      } else {
                        VoucherData _data = voucherData[_selectedVoucher];

                        return ListTile(
                          title: Text(_data.voucherTitle),
                          subtitle: Text(_data.voucherSubtitle),
                          leading: _data.leading,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
