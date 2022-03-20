import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedProvider extends StateNotifier<List<String>> {
  SelectedProvider() : super([]);

  addToSelected(String _productID) {
    state.add(_productID);
    state = state.toSet().toList();
  }

  removeFromSelected(String _productID) {
    state.remove(_productID);
    state = state.toList();
  }

  clearSelected() {
    state = [];
  }
}
