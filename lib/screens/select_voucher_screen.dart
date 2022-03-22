import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';
import 'package:git_tees_shop/core/utilites.dart';
import 'package:git_tees_shop/data_classes/voucher_data.dart';

class SelectVoucherScreen extends ConsumerWidget {
  const SelectVoucherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            ref.read(selectedVoucherProvider.state).state = null;
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: const Text('Select Git`Tee Voucher'),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          ...voucherList(ref)
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.blue,
          height: kBottomNavigationBarHeight,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'Apply selected voucher',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Column voucherTiles(VoucherData _data, WidgetRef ref) {
    bool isSelected = ref.watch(selectedVoucherProvider) == _data.voucherID;
    bool enabled = false;

    int _totalQuantity = ref.watch(totalProductQuantityProvider);
    double _totalPrice = ref.watch(totalPriceProvider);

    switch (_data.voucherID) {
      case 0:
        if (_totalPrice >= 500 && _totalQuantity >= 5) {
          enabled = true;
        }
        break;
      case 1:
        if (_totalPrice >= 1000 && _totalQuantity >= 10) {
          enabled = true;
        }
        break;
      case 2:
        if (_totalPrice >= 3000 && _totalQuantity >= 30) {
          enabled = true;
        }
        break;
      case 3:
        if (_totalPrice >= 300) {
          enabled = true;
        }
        break;
      default:
        enabled = false;
        break;
    }

    return Column(
      children: [
        ListTile(
          enabled: enabled,
          title: Text(_data.voucherTitle),
          subtitle: Text(_data.voucherSubtitle),
          leading: _data.leading,
          trailing: Checkbox(
            onChanged: !enabled
                ? null
                : (selected) {
                    if (isSelected) {
                      ref.read(selectedVoucherProvider.state).state = null;
                    } else {
                      ref.read(selectedVoucherProvider.state).state = _data.voucherID;
                    }
                  },
            value: isSelected,
          ),
        ),
        const Divider(),
      ],
    );
  }

  List<Column> voucherList(WidgetRef ref) {
    return voucherData.map((voucher) {
      return voucherTiles(voucher, ref);
    }).toList();
  }
}
