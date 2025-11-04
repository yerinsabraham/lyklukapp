import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lykluk/core/services/services.dart';
import 'package:lykluk/core/shared/resources/failure.dart';
import 'package:lykluk/core/shared/resources/response_data.dart';
import 'package:lykluk/core/shared/resources/typedefs.dart';
import 'package:lykluk/modules/auth/data/models/auth_response.dart';
import 'package:lykluk/modules/auth/data/models/user_interest_model.dart';
import 'package:lykluk/modules/auth/domain/repo/auth_repo.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../../../../../core/services/network/endpoints.dart';

final authRepoProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
    apiService: ref.read(apiServiceProvider),
    analyticsService: ref.read(analyticsServiceProvider),
  );
});


class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;
  final AnalyticsService analyticsService;
  const AuthRepositoryImpl({
    required this.apiService,
    required this.analyticsService,
  });

  @override
  FutureResponse<StringMap> logout()async {
    try {
      final response = await apiService.postData(
        Endpoints.authLogout,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        HiveStorage.clearBoxes();
        return Right(
          ResponseData(
            data: {},
            message: response.message ?? "Logout successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to logout, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Logout failed",
        errorCode: "LOGOUT_FAILED",
      );
      return Left(
        Failure("Error occurred while logging out, please try again later"),
      );
    }
  }

  @override
  FutureResponse<StringMap> refreshToken() async{
   try {
      final response = await apiService.postData(
        Endpoints.authRefreshToken,
        hasHeader: true,
      );
      if (response.isSuccessful) {
        return Right(
          ResponseData(
            data: {},
            message: response.message ?? "Refresh token successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to refresh token, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Refresh token failed",
        errorCode: "REFRESH_TOKEN_FAILED",
      );
      return Left(
        Failure("Error occurred while refreshing token, please try again later"),
      );
    }
  }


  @override
  FutureResponse<StringMap> resetPassword({required Map<String, dynamic> body}) async{
   try {
      final response = await apiService.postData(
        Endpoints.authResetPassword,
         hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final map= Map<String, dynamic>.from(data['data']);

        return Right(
          ResponseData(
            data: map,
            message: response.message ?? "password updated successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to update password, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "password update failed",
        errorCode: "UPDATE_PASSWORD_FAILED",
      );
      return Left(
        Failure("Error occurred while updating password, please try again later"),
      );
    }
  }

  @override
  FutureResponse<AuthResponse> signIn({required Map<String, dynamic> body})async {
   try {
      final response = await apiService.postData(
        Endpoints.authSignIn,
         hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = Map<String, dynamic>.from(response.data );
        final authResponse = AuthResponse.fromJson(data['data']);

        /// save to local storage
        HiveStorage.saveUser = authResponse.siginUser!.toJson();
        HiveStorage.accessToken = authResponse.accessToken;
        HiveStorage.refreshToken = authResponse.refreshToken?? "";
        return Right(
          ResponseData(
            data: authResponse,
            message: response.message ?? "Sign in successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to sign in, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Sign in failed",
        errorCode: "SIGN_IN_FAILED",
      );
      return Left(
        Failure("Error occurred while signing in, please try again later"),
      );
    }
  }

  @override
  FutureResponse<AuthResponse> signUp({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await apiService.postData(
        Endpoints.authSignUp,
          hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = Map<String, dynamic>.from(response.data);
        final authResponse = AuthResponse.fromJson(data['data']);

        /// save to local storage
        HiveStorage.saveUser = authResponse.siginUser!.toJson();
        HiveStorage.accessToken = authResponse.accessToken;
        HiveStorage.refreshToken = authResponse.refreshToken?? "";
        return Right(
          ResponseData(
            data: authResponse,
            message: response.message ?? "Sign up successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to sign up, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Sign up failed",
        errorCode: "SIGN_UP_FAILED",
      );
      return Left(
        Failure("Error occurred while signing up, please try again later"),
      );
    }
  }

  @override
  FutureResponse<AuthResponse> socialSignIn({
    required Map<String, dynamic> body,
  }) async{
   try {
      final response = await apiService.postData(
         Endpoints.authSocial,
           hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = Map<String, dynamic>.from(response.data);
        final authResponse = AuthResponse.fromJson(data['data']);
        
        /// save to local storage
        HiveStorage.saveUser = authResponse.siginUser!.toJson();
        HiveStorage.accessToken = authResponse.accessToken;
        HiveStorage.refreshToken = authResponse.refreshToken?? "";
        return Right(
          ResponseData(
            data: authResponse,
            message: response.message ?? "Sign in successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to sign in, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Sign in failed",
        errorCode: "SOCIAL_SIGN_IN_FAILED ",
      );
      return Left(
        Failure("Error occurred while signing in, please try again later"),
      );
    }
  }

  @override
  FutureResponse<StringMap> updatePassword({required Map<String, dynamic> body})async {
   try {
      final response = await apiService.putData(
        Endpoints.authUpdatePassword,
         hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final map= Map<String, dynamic>.from(data['data']);

        return Right(
          ResponseData(
            data: map,
            message: response.message ?? "password updated successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to update password, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "password update failed",
        errorCode: "UPDATE_PASSWORD_FAILED",
      );
      return Left(
        Failure("Error occurred while updating password, please try again later"),
      );
    }
  }

  @override
  FutureResponse<StringMap> verifyCode({required Map<String, dynamic> body})async {
   try {
      final response = await apiService.postData(
        Endpoints.authVerify,
         hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final map= Map<String, dynamic>.from(data['data']);

        return Right(
          ResponseData(
            data: map,
            message: response.message ?? "Verification code verified successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to verify code, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Verification code verification failed",
        errorCode: "VERIFY_CODE_FAILED",
      );
      return Left(
        Failure("Error occurred while verifying code, please try again later"),
      );
    }
  }


  @override
  FutureResponse<StringMap> sendVerification({
    required Map<String, dynamic> body,
  }) async{
   try {
      final response = await apiService.postData(
        Endpoints.authSendVerification,
         hasHeader: true,
        body: body,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final map= Map<String, dynamic>.from(data['data']);

        return Right(
          ResponseData(
            data: map,
            message: response.message ?? "Verification code sent successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to send verification code, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Verification code sending failed",
        errorCode: "SEND_VERIFICATION_FAILED",
      );
      return Left(
        Failure("Error occurred while sending verification code, please try again later"),
      );
    }
  }
  
  @override
  FutureResponse<List<UserInterestModel>> getInterests()async {
   try {
      final response = await apiService.getData(
        Endpoints.interests,
         hasHeader: true,
      );
      if (response.isSuccessful) {
        final data = response.data;
        final map= Map<String, dynamic>.from(data);
        final  rawList = map['data'] as List;
        final interests = rawList.map((e) => UserInterestModel.fromJson(e)).toList(); 

        return Right(
          ResponseData(
            data: interests,
            message: response.message ?? "Interests fetched successful",
          ),
        );
      } else {
        return Left(
          Failure(
            response.message ?? "Unable to fetch interests, please try again later",
          ),
        );
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Fetching interests failed",
        errorCode: "FETCH_INTERESTS_FAILED",
      );
      return Left(
        Failure("Error occurred while fetching interests, please try again later"),
      );
    }
  }
  
}
