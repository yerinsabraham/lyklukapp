import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/auth/data/models/auth_response.dart';

import '../../data/models/user_interest_model.dart';

/// Contract for all Authentication endpoints.
abstract class AuthRepository {
  // ─────────────── AUTH ───────────────
  FutureResponse<AuthResponse> signUp({required Map<String, dynamic> body});

  FutureResponse<AuthResponse> socialSignIn({
    required Map<String, dynamic> body,
  });

  FutureResponse<AuthResponse> signIn({required Map<String, dynamic> body});

  FutureResponse<StringMap> refreshToken();

  FutureResponse<StringMap> resetPassword({required Map<String, dynamic> body});

  FutureResponse<StringMap> updatePassword({
    required Map<String, dynamic> body,
  });

  FutureResponse<StringMap> logout();

  // ─────────────── VERIFICATION ───────────────
  FutureResponse<StringMap> verifyCode({required Map<String, dynamic> body});

  FutureResponse<StringMap> sendVerification({
    required Map<String, dynamic> body,
  });

  FutureResponse<List<UserInterestModel>> getInterests();
}
