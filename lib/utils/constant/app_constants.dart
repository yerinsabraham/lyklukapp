class AppConstant {
  AppConstant._();

  static const String appName = 'Lykluk';

  /// timeout is set to 40 seconds
  static const timeOut = Duration(seconds: 40);

  /// Rxg
  static const String emailReg = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String upperCaseReg = r'^(?=.*[A-Z])';
  static const String alphanumeric = r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]+$';
  static const String passwordValid =
      r'^(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d]{8,}$';
}
