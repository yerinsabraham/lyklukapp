import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lykluk/core/services/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';




class OAuthService {
 
  static String generatingAEncryptionKey([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String generatingSHA256Key(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// google sign login
  static Future<GoogleSignInAccount> googleSignIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) throw 'Google Sign In Failed';
      return googleSignInAccount;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
    } catch (e, s) {
      // rethrow;
      LoggerService.logError(
          reason: 'Failed to sign out: $e', stackTrace: s, error: e);
    }
  }

  static Future<AuthorizationCredentialAppleID> appleSignIn() async {
    final rawNonce = generatingAEncryptionKey();
    // ignore: unused_local_variable
    final nonce = generatingSHA256Key(rawNonce);
    // ignore: unused_local_variable
    const redirectUrl =
        'https://trapezoidal-fuzzy-hisser.glitch.me/callbacks/sign_in_with_apple';

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: Platform.isIOS ? nonce : null,
        // webAuthenticationOptions: Platform.isIOS
        //     ? null
        //     : WebAuthenticationOptions(
        //         clientId: "com.chattabox.www",
        //         redirectUri: Uri.parse(redirectUrl),
        //       ),
      );
      return credential;
    } catch (e, s) {
      log.e('Error during Apple sign-in: $e', stackTrace: s);
      throw Exception('Failed to sign in with Apple: $e');
    }
  }
}
