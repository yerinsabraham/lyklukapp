import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lykluk/core/shared/model/profile_model.dart';

import '../../../data/models/other_user.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory   ProfileState.initial() = ProfileStateInital;
  const factory ProfileState.updating() = ProfileStateUpdating;
  const factory ProfileState.updated({ProfileModel? data, required String message }) = ProfileStateUpdated;
 const  factory ProfileState.updatingFailed({required String message}) = ProfileStateUpdatingFailed;

    /// follow state
  const  factory ProfileState.follow({required bool follow, required String userId}) = Follow;
  const  factory ProfileState.followFailed({required bool follow, required String userId, required String message}) = FollowFailed;
  const  factory ProfileState.unfollow({required bool follow, required String userId}) = UnFollow;
  const  factory ProfileState.unfollowFailed({required bool follow, required String userId, required String message}) = UnFollowFailed;

    ///block state
  const  factory ProfileState.blocking() = Block;
 const factory ProfileState.blocked({OtherUser? data, required String message}) = Blocked;
  const factory ProfileState.blockFailed({required String message}) = BlockFailed;

    /// update settings state
  const  factory ProfileState.updatingSettings() = ProfileStateUpdatingSettings;
 const factory ProfileState.updatedSettings({dynamic data, required String message}) =
      ProfileStateUpdatedSettings;
 const factory ProfileState.updatingSettingsFailed({required String message}) =
      ProfileStateUpdatingSettingsFailed;



  /// delete profile state
  const factory ProfileState.deletingProfile() = DeletingProfile;
 const factory ProfileState.deletedProfile({required String message}) = DeletedProfile;
 const factory ProfileState.deletingProfileFailed({required String message}) = DeletingProfileFailed;

}
