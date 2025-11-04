import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/profile/data/models/user_profile.dart';
import 'package:lykluk/utils/assets_manager.dart';

import '../../../modules/profile/presentation/view_model/providers/profile_provider.dart';
import '../../../utils/storage/local_storage.dart';

class ProfileCircularAvatar extends HookConsumerWidget {
  final int? size;
  const ProfileCircularAvatar({super.key, this.size});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(
      usersProfileProvider(
        HiveStorage.username,
      ).select((v) => v.valueOrNull?.imageUrl),
    );
    return url==null?CircleAvatar(
      radius: size?.toDouble() ?? 20.0,
      child: SvgPicture.asset(IconAssets.person2Icon)
    ) :ProfileAvatar(
      isProfile: true,
      imageUrl: url,
      radius: size ?? 20,
      placeholderValue: HiveStorage.username.substring(1, 3).toUpperCase(),
    );
  }
}
