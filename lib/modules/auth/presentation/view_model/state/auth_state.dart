import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lykluk/modules/auth/data/models/auth_response.dart';


part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
   factory AuthState.initial() = AuthStateInitail;

  /// login
  factory AuthState.loginLoading() = AuthStateLoginLoading;
  factory AuthState.googleSignInLoading() = AuthStateGoogleSignInLoginLoading;
  factory AuthState.appleSignInLoading() = AuthStateAppleSignInLoading;
  factory AuthState.loginSuccess({required AuthResponse authResponse , required String message}) = AuthStateLoginSuccess;
  factory AuthState.googleLoginSuccess({required AuthResponse authResponse , required String message}) = AuthStateGoogleLoginSuccess;
  factory AuthState.appleLoginSuccess({required AuthResponse authResponse , required String message}) = AuthStateAppleLoginSuccess;
  factory AuthState.loginFailure(String message) = _AuthStateLoginFailure;
  factory AuthState.appleSignInFailure(String message) = _AuthStateAppleSignInFailure;
  factory AuthState.googleSignInFailure(String message) = _AuthStateGoogleSignInFailure;

  //  sign up
   factory AuthState.signUpLoading() = AuthStateSignUpLoading;
  factory AuthState.signUpSuccess({required AuthResponse authResponse , required String message}) = AuthStateSignUpSuccess;
   factory AuthState.signUpFailure(String message) = AuthStateSignUpFailure;


   //  logout
   factory AuthState.logoutLoading() = AuthStateLogoutLoading;
   factory AuthState.logoutSuccess({required String message}) = AuthStateLogoutSuccess;
   factory AuthState.logoutFailure(String message) = AuthStateLogoutFailure;

   /// reset password
   factory AuthState.resetPasswordLoading() = AuthStateResetPasswordLoading;
   factory AuthState.resetPasswordSuccess({required String message}) = AuthStateResetPasswordSuccess;
   factory AuthState.resetPasswordFailure(String message) = AuthStateResetPasswordFailure;

   /// reset password
   factory AuthState.forgotPasswordLoading() = AuthStateForgotPasswordLoading;
   factory AuthState.forgotPasswordSuccess({required String message}) = AuthStateForgotPasswordSuccess;
   factory AuthState.forgotPasswordFailure(String message) = AuthStateForgotPasswordFailure;


   /// send otp code
   factory AuthState.sendOtpLoading() = AuthStateSendOtpLoading;
   factory AuthState.sendOtpSuccess({required String message, required String otpCode}) = AuthStateSendOtpSuccess;
   factory AuthState.sendOtpFailure(String message) = AuthStateSendOtpFailure;

   /// verify otp code
   factory AuthState.verifyOtpLoading() = AuthStateVerifyOtpLoading;
   factory AuthState.verifyOtpSuccess({required String message}) = AuthStateVerifyOtpSuccess;
   factory AuthState.verifyOtpFailure(String message) = AuthStateVerifyOtpFailure;


  /// update password
  factory AuthState.updatePasswordLoading() = UpdatePasswordLoading;
  factory AuthState.updatePasswordSuccess({required String message}) = UpdatePasswordSuccess;
  factory AuthState.updatePasswordFailure(String message) = UpdatePasswordFailure;





}