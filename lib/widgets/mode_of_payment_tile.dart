import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_tees_shop/core/providers_definition.dart';

class ModeOfPaymentTile extends ConsumerWidget {
  const ModeOfPaymentTile({Key? key}) : super(key: key);

  static const List<String> _paymentOptions = [
    'Cash',
    'Gcash',
    'Credit Card',
    'Utang',
  ];

  static String paymentMethod = _paymentOptions.first;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Payment Method',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                  isDense: true,
                  menuMaxHeight: 300,
                  value: _paymentOptions.first,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? newValue) {
                    paymentMethod = newValue!;
                    ref.read(paymentMethodProvider.state).state = paymentMethod;
                  },
                  items: _paymentOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        value,
                      ),
                      value: value,
                      enabled: value != _paymentOptions.last,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
