extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> get removeNullValues {
    return Map<K, V>.fromEntries(entries.where((e) => e.value != null));
  }
}
