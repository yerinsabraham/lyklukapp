// ignore_for_file: invalid_use_of_internal_member, depend_on_referenced_packages, implementation_imports

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod/src/async_notifier.dart';

import '../../core/services/services.dart';
import '../../core/shared/providers/auth_status_provider.dart';


mixin AsyncMixins<T> on AsyncNotifierBase<T> {
  void onNetworkStatusChange() {
    InternetConnection().onStatusChange.listen((status) {
      // log.d('NETWORK STATE: ${status.toString()}');
      if (status == InternetStatus.connected && state.hasError) {
        log.d('REFRESH PROVIDER:${state.runtimeType} ');
        ref.invalidateSelf(); // Refresh provider if network is back
      }
    });
  }

  void onAuthStateChanged(
      {required T initialData, Function()? onAuthenicated}) {
    ref.listen(authStateProvider, (p, n) {
      if (n == false) {
        log.d('UNAUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');

        /// reset provider to initial state
        reset(initialData);
      } else {
        log.d('AUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');
        onAuthenicated?.call();
      }
    });
  }
  /// used to set provider state to initial data
  void reset(T initialData) {
    /// reset provider to initial state
    state = AsyncValue.data(initialData);
  }
  /// used to trigger provider refresh
  void refresh(){
    ref.invalidateSelf();
  }
}
mixin NofiterMixins<T> on Notifier<T> {
  void onNetworkStatusChange({bool isError = false}) {
    InternetConnection().onStatusChange.listen((status) {
      // log.d('NETWORK STATE: ${status.toString()}');
      if (status == InternetStatus.connected && isError) {
        log.d('REFRESH PROVIDER:${state.runtimeType} ');
        ref.invalidateSelf(); // Refresh provider if network is back
      }
    });
  }

  void onAuthStateChanged(
      {required T initialData, Function()? onAuthenicated}) {
    ref.listen(authStateProvider, (p, n) {
      if (n == false) {
        log.d('UNAUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');

        /// reset provider to initial state
        reset(initialData);
      } else {
        log.d('AUTHENTICATED: REFRESH PROVIDER:${state.runtimeType} ');
        onAuthenicated?.call();
      }
    });
  }

  void reset(T initialData) {
    /// reset provider to initial state
    state = initialData;
  }
}
