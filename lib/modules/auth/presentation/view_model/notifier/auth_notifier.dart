import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/oauth_service.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/modules/auth/data/repository/impl/auth_repo_impl.dart';
import 'package:lykluk/modules/auth/presentation/view_model/state/auth_state.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import '../../../data/models/login_req.dart';
import '../../../data/models/signup_req.dart';
import '../../../domain/repo/auth_repo.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;
  // late final AnalyticsService _analyticsService;
  @override
  build() {
    _authRepository = ref.read(authRepoProvider);
    // _analyticsService = ref.read(analyticsServiceProvider);
    return AuthState.initial();
  }

  void signUp({required SignUpRequest request}) async {
    try {
      state = AuthState.signUpLoading();
      final result = await _authRepository.signUp(body: request.toJson());
      result.fold(
        (l) {
          state = AuthState.signUpFailure(l.message);
        },
        (r) {
          state = AuthState.signUpSuccess(
            authResponse: r.data,
            message: r.message,
          );
        },
      );
    } catch (e) {
      state = AuthState.signUpFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  void login({required LoginRequest request}) async {
    try {
      state = AuthState.loginLoading();
      final result = await _authRepository.signIn(body: request.toRequest());
      result.fold(
        (l) {
          state = AuthState.loginFailure(l.message);
        },
        (r) {
          state = AuthState.loginSuccess(
            authResponse: r.data,
            message: r.message,
          );
        },
      );
    } catch (e) {
      state = AuthState.loginFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  void logout() async {
    try {
      state = AuthState.logoutLoading();
      final result = await _authRepository.logout();
      result.fold(
        (l) {
          state = AuthState.logoutFailure(l.message);
        },
        (r) {
          state = AuthState.logoutSuccess(message: r.message);
        },
      );
    } catch (e) {
      state = AuthState.logoutFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  void forgotPassword({required String email}) async {
    try {
      state = AuthState.forgotPasswordLoading();
      final result = await _authRepository.resetPassword(
        body: {'email': email},
      );
      result.fold(
        (l) {
          state = AuthState.forgotPasswordFailure(l.message);
        },
        (r) {
          state = AuthState.forgotPasswordSuccess(message: r.message);
        },
      );
    } catch (e) {
      state = AuthState.resetPasswordFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  void verifyCode({required String code, required String email}) async {
    try {
      state = AuthState.verifyOtpLoading();
      final result = await _authRepository.verifyCode(
        body: {'email': email, 'code': code},
      );
      result.fold(
        (l) {
          state = AuthState.verifyOtpFailure(l.message);
        },
        (r) {
          state = AuthState.verifyOtpSuccess(message: r.message);
        },
      );
    } catch (e) {
      state = AuthState.verifyOtpFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  void updatePassword({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      state = AuthState.updatePasswordLoading();
      final result = await _authRepository.updatePassword(
        body: {'to': email, 'password': password, 'code': code},
      );
      result.fold(
        (l) {
          state = AuthState.updatePasswordFailure(l.message);
        },
        (r) {
          state = AuthState.updatePasswordSuccess(message: r.message);
        },
      );
    } catch (e) {
      state = AuthState.updatePasswordFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  Future<void> socialSignIn({
    required String provider, // e.g., 'google', 'apple'
    required String accessToken,
  }) async {
    try {
      final res = await _authRepository.socialSignIn(
        body: {"provider": provider, "accessToken": accessToken},
      );
      res.fold(
        (l) {
          state = AuthState.loginFailure(l.message);
        },
        (r) {
          if (provider == 'google') {
            state = AuthState.googleLoginSuccess(
              authResponse: r.data,
              message: r.message,
            );
          } else if (provider == 'apple') {
            state = AuthState.appleLoginSuccess(
              authResponse: r.data,
              message: r.message,
            );
          } else {
            state = AuthState.loginSuccess(
              authResponse: r.data,
              message: r.message,
            );
          }
        },
      );
    } catch (e) {
      state = AuthState.loginFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  /// send Code
  void sendCode({required String to, required bool isEmail}) async {
    try {
      state = AuthState.sendOtpLoading();
      final result = await _authRepository.sendVerification(
        body: isEmail ? {'email': to} : {'phone': to},
      );
      result.fold(
        (l) {
          state = AuthState.sendOtpFailure(l.message);
        },
        (r) {
          state = AuthState.sendOtpSuccess(
            message: r.message,
            otpCode: r.data['code'],
          );
        },
      );
    } catch (e) {
      state = AuthState.sendOtpFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }

  /// google sign in
  void googleSignIn() async {
    try {
      state = AuthState.googleSignInLoading();
      final user = await OAuthService.googleSignIn();
      final gogleAuth = await user.authentication;
      // log.d(gogleAuth);
      final idToken = gogleAuth.idToken;
      if (idToken == null) {
        // state = const AuthState.googleLoginSuccess(message: "Unable to sign in.", );
        state = AuthState.googleSignInFailure("Unable to sign in.");
        return;
      }
      final res = await ref
          .read(authRepoProvider)
          .socialSignIn(
            body: {
              "provider": "google",
              "idToken": idToken,
              "interestIds": HiveStorage.interests,
            },
          );

      res.fold(
        (l) {
          state = AuthState.googleSignInFailure(l.message);
        },
        (r) async {
          state = AuthState.googleLoginSuccess(
            message: r.message,
            authResponse: r.data,
          );
        },
      );
    } catch (e, s) {
      log.e(e, stackTrace: s);
      state = AuthState.googleSignInFailure(e.toString());
    }
  }

  void appleSignIn() async {
    try {
      state = AuthState.appleSignInLoading();
      final credentials = await OAuthService.appleSignIn();
      if (credentials.identityToken == null) {
        state = AuthState.appleSignInFailure("Unable to sign in.");
        return;
      }
      final res = await ref
          .read(authRepoProvider)
          .socialSignIn(
            body: {
              "provider": "apple",
              "idToken": credentials.identityToken,
              "interestIds": HiveStorage.interests,
            },
          );

      res.fold(
        (l) {
          state = AuthState.appleSignInFailure(l.message);
        },
        (r) async {
          state = AuthState.appleLoginSuccess(
            message: r.message,
            authResponse: r.data,
          );
        },
      );
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Apple sign in failed",
      );
      state = AuthState.appleSignInFailure(e.toString());
    } finally {
      state = AuthState.initial();
    }
  }
}
