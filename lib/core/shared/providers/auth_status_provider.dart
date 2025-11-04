import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/network/socket_io_manager.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../modules/auth/presentation/view_model/notifier/auth_notifier.dart';

/// Exposes the current AuthViewState and lets you mutate it from VMs.
// final authNotifierProvider = NotifierProvider<AuthNotifier, AuthViewState>(
//   AuthNotifier.new,
// );

// class AuthNotifier extends Notifier<AuthViewState> {
//   @override
//   AuthViewState build() => const AuthViewState();

//   void setSigningUp(bool v) => state = state.copyWith(isSigningUp: v);
//   void setSigningIn(bool v) => state = state.copyWith(isSigningIn: v);
//   void setSocialSigningIn(bool v) =>
//       state = state.copyWith(isSocialSigningIn: v);
//   void setResettingPassword(bool v) =>
//       state = state.copyWith(isResettingPassword: v);
//   void setUpdatingPassword(bool v) =>
//       state = state.copyWith(isUpdatingPassword: v);
//   void setLoggingOut(bool v) => state = state.copyWith(isLoggingOut: v);
//   void setRefreshingToken(bool v) =>
//       state = state.copyWith(isRefreshingToken: v);

//   void setError(String? msg) => state = state.copyWith(errorMessage: msg);

//   void setSignUpResponse(SignUpRes res) =>
//       state = state.copyWith(signUpResponse: res);

//   void setSocialSignInResponse(ApiResponse res) =>
//       state = state.copyWith(socialSignInResponse: res);

//   void setSignInResponse(LoginRes res) =>
//       state = state.copyWith(signInResponse: res);

//   void setResetPasswordResponse(ApiResponse res) =>
//       state = state.copyWith(resetPasswordResponse: res);

//   void setUpdatePasswordResponse(ApiResponse res) =>
//       state = state.copyWith(updatePasswordResponse: res);

//   void setLogoutResponse(ApiResponse res) =>
//       state = state.copyWith(logoutResponse: res);

//   void setRefreshTokenResponse(ApiResponse res) =>
//       state = state.copyWith(refreshTokenResponse: res);
// }

/// Tracks whether user is logged in or not.
final authStateProvider = NotifierProvider<AuthStateNotifier, bool>(
  AuthStateNotifier.new,
  name: 'authStateProvider',
);

class AuthStateNotifier extends Notifier<bool> {
  @override
  bool build() {
    _listenAuthChanges();
    return _checkStatus();
  }

  bool _checkStatus() {
    final canLogin = HiveStorage.isLoggedIn;
    if (canLogin) SocketIOManager.instance;
    return canLogin;
  }

  void update(bool value) {
    HiveStorage.isLoggedIn == value;
    HiveStorage.isOnboarded == value;
    state = value;
  }

  void _listenAuthChanges() {
    ref.listen(authNotifierProvider, (prev, current) {
      current.maybeWhen(
        orElse: () {},
        signUpSuccess: (authResponse, message) {
          HiveStorage.isLoggedIn == true;
          SocketIOManager.instance;
          state = true;
        },
        loginSuccess: (authResponse, message) {
          HiveStorage.isLoggedIn == true;
          SocketIOManager.instance;
          state = true;
        },
        logoutSuccess: (message) {
          SocketIOManager.instance.disconnect();
          state = false;
        },
      );
      // final bool loginSuccess =
      //     current.signInResponse?.success == true ||
      //     current.socialSignInResponse?.isSuccessful == true ||
      //     current.signUpResponse?.success == true;

      // final bool logoutSuccess = current.logoutResponse?.isSuccessful == true;

      // if (loginSuccess) {
      //   HiveStorage.isLoggedIn == true;
      //   SocketIOManager.instance;
      //   state = true;
      // } else if (logoutSuccess) {
      //   HiveStorage.isLoggedIn == false;
      //   SocketIOManager.instance.disconnect();
      //   state = false;
      // }
    });
  }
}
