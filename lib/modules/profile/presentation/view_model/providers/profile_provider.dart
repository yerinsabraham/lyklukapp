import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/modules/profile/data/models/user_profile.dart';
import 'package:lykluk/modules/profile/data/repository/impl/profile_repo_impl.dart';
import 'package:lykluk/modules/profile/domain/repo/profile_repo.dart';
import 'package:lykluk/utils/mixins/async_mixins.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import '../notifiers/profile_notifier.dart';

final profileProvider = AsyncNotifierProvider<ProfileNotifier, UserProfile>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<UserProfile> with AsyncMixins {
  late ProfileRepository _repository;
  @override
  FutureOr<UserProfile> build() {
    _repository = ref.read(profileRepoProvider);
    onAuthStateChanged(
      initialData: UserProfile.empty(),
      onAuthenicated: () {
        loadFromLocal();
        ref.invalidateSelf();
      },
    );
    onNetworkStatusChange();
    onProfileUpdate();
    return loadData();
  }

  FutureOr<UserProfile> loadData() async {
    try {
      final response = await _repository.getProfile(
        userId: HiveStorage.userId,
      );

      if (response.isSuccessful) {
        final raw = (response.data as Map<String, dynamic>)['data'];
        return UserProfile.fromJson(raw);
      } else {
        return Future.error(response.message ?? "Unable to fetch profile");
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to fetch profile -- ProfileVideosNotifier",
      );
      return Future.error("something went wrong, please try again later");
    }
  }

  void loadFromLocal() {
    final user = HiveStorage.getUser;
    state = AsyncValue.data(user);
  }

  void onProfileUpdate() {
    ref.listen(profileNotifierProvider, (p, n) {
      n.maybeWhen(
        orElse: () {},
        updated: (data, message) {
          if (data == null) return ref.invalidateSelf();
          final newUser = state.requireValue.copyWith(profile: data);
          state = AsyncValue.data(newUser);
        },
      );
    });
  }
}

final usersProfileProvider =
    AsyncNotifierProviderFamily<UsersProfileNotifier, UserProfile, String>(
      UsersProfileNotifier.new,
    );

class UsersProfileNotifier extends FamilyAsyncNotifier<UserProfile, String>
    with AsyncMixins {
  late ProfileRepository _repository;
  @override
  FutureOr<UserProfile> build(arg) {
    _repository = ref.read(profileRepoProvider);
    onAuthStateChanged(
      initialData: UserProfile.empty(),
      onAuthenicated: () {
        ref.invalidateSelf();
      },
    );
    onNetworkStatusChange();
    return loadData();
  }

  FutureOr<UserProfile> loadData() async {
    try {
      final response = await _repository.getProfileByUserName(userName: arg);

      if (response.isSuccessful) {
        final raw = (response.data as Map<String, dynamic>)['data'];
        return UserProfile.fromJson(raw);
      } else {
        return Future.error(response.message ?? "Unable to fetch profile");
      }
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: "Unable to fetch profile -- ProfileVideosNotifier",
      );
      return Future.error("something went wrong, please try again later");
    }
  }
}
