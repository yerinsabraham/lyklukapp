enum Currency {
  usd(flag: '🇺🇸', asset: 'assets/image/usd.png', name: 'USD', symbol: '＄'),
  // ngn(flag: '🇳🇬', asset: 'assets/svg/naira.svg', name: 'NGN', symbol: '₦'),
  eur(flag: '🇪🇺', asset: 'assets/image/eur.png', name: 'EUR', symbol: '€'),
  gdp(
    flag: '🇬🇧',
    asset: 'assets/svg/pounds.png',
    name: 'POUNDS',
    symbol: '￡',
  );

  final String flag;
  final String asset;
  final String name;
  final String symbol;
  const Currency({
    required this.flag,
    required this.asset,
    required this.name,
    required this.symbol,
  });
}

extension CurrencyExt on String {
  /// get currency symbol from currency name
  Currency get currency {
    switch (toLowerCase()) {
      case 'usd':
        return Currency.usd;
      case 'pounds':
        return Currency.gdp;
      case 'eur':
        return Currency.eur;
      default:
        return Currency.usd;
    }
  }

  /// get currency symbol from currency name
  String get currencySymbol {
    switch (toLowerCase()) {
      case 'usd':
        return Currency.usd.symbol;
      // case 'ngn':
      //   return Currency.ngn.symbol;
      case 'eur':
        return Currency.eur.symbol;
      default:
        return Currency.usd.symbol;
    }
  }
}
