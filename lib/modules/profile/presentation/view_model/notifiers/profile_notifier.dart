import 'package:lykluk/core/shared/model/profile_model.dart';
import 'package:lykluk/modules/profile/data/repository/impl/profile_repo_impl.dart';
import 'package:lykluk/modules/profile/domain/repo/profile_repo.dart';
import 'package:riverpod/riverpod.dart';

import '../state/profile_state.dart';

final profileNotifierProvider = NotifierProvider<ProfileNotifier, ProfileState >(ProfileNotifier.new);

class ProfileNotifier extends Notifier<ProfileState> {
  // late AnalyticsService _analyticsService;
  late ProfileRepository _profileRepository;
  @override
  build() {
    // _analyticsService = ref.read(analyticsServiceProvider);
    _profileRepository = ref.read(profileRepoProvider);
    return ProfileState.initial();
  }

  void follow({required String userName}) {}

  void unfollow({required String userName}) {}

  void editProfile({required Map<String, dynamic> data}) async {
    try {
      state = ProfileStateUpdating();
      final res = await _profileRepository.editProfile(body: data);
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        state = ProfileStateUpdated(
          data: raw['profile'] != null ? ProfileModel.fromJson(raw['profile']): null,
          message: res.message ?? "Profile updated successfully",
        );
      } else {
        state = ProfileStateUpdatingFailed(
          message: res.message ?? "Failed to update profile",
        );
      }
    } catch (e) {
      state = ProfileState.updatingFailed(message: e.toString());
    }
  }

  /// Update profile picture
  void editProfilePic({String? avatar}) async {
    try {
      state = ProfileState.updating();
      final res = await _profileRepository.editProfilePic(body: {'avatar': avatar});
      if (res.isSuccessful) {
        final raw = (res.data as Map<String, dynamic>)['data'];
        state = ProfileState.updated(
          data: raw['profile'] != null ? ProfileModel.fromJson(raw['profile']) : null,
          message: res.message ?? 'Profile picture updated',
        );
      } else {
        state = ProfileState.updatingFailed(
          message: res.message ?? 'Failed to update profile picture',
        );
      }
    } catch (e) {
      state = ProfileState.updatingFailed(message: e.toString());
    }
  }

  void block() {}
  void updateSetting({required Map<String, dynamic> data}) {}
}
