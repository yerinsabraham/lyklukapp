import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/ecommerce/model/address_model.dart';

final addressesProvider =
    AsyncNotifierProvider<AddressListNotifier, List<AddressModel>>(
      AddressListNotifier.new,
    );

class AddressListNotifier extends AsyncNotifier<List<AddressModel>> {
  @override
  FutureOr<List<AddressModel>> build() {
    return loadData();
  }

  FutureOr<List<AddressModel>> loadData() async {
    // TODO: Implement load data from server
    return [];
  }

  void add(AddressModel address) {
    // TODO: Implement add address to server
    final newList = [...state.requireValue, address];
    state = AsyncValue.data(newList);
  }

  void remove(AddressModel address) {
    // TODO: Implement remove address from server
    final newList = [...state.requireValue];
    newList.remove(address);
    state = AsyncValue.data(newList);
  }

  void updateAddress(AddressModel address) {
    // TODO: Implement update address to server
    final newList = [...state.requireValue];
    final index = newList.indexWhere((element) => element.id == address.id);
    if (index == -1) {
      return;
    }
    newList[index] = address;
    state = AsyncValue.data([...newList]);
  }
}
