import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';

class AppProviderObservers extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    log.d('''
    Provider added: $provider
    Value: $value
    ''');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log.d('''
    Provider disposed: $provider
    ''');
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.d('''
    Provider updated: $provider
    ''');
    log.d(newValue);
  }
}
