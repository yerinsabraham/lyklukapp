import 'dart:async';

import 'package:country_state_city/country_state_city.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/mixins/async_mixins.dart';

final statesProvider =
    AsyncNotifierProviderFamily<StateNotifier, List<State>, String>(
      StateNotifier.new,
    );

class StateNotifier extends FamilyAsyncNotifier<List<State>, String>
    with AsyncMixins {
  @override
  FutureOr<List<State>> build(arg) {
    onNetworkStatusChange();
    onAuthStateChanged(initialData: []);
    return load();
  }

  FutureOr<List<State>> load() async {
    try {
      final res =  await getStatesOfCountry(arg);
      if(res.isEmpty){  
         return Future.error('No data found');
      }else{
         return res;
      }
      
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
