import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/chats/presentation/widgets/chat_input.dart';
import 'package:lykluk/modules/chats/presentation/widgets/media_choice_sheet.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/helpers/show_sheet.dart';
import 'package:lykluk/utils/storage/local_storage.dart';

import 'widgets/chat_page_body.dart';

class ChatPage extends HookConsumerWidget {
  final String chatId;
  const ChatPage({super.key, required this.chatId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ChatAppBar(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0.h),
        child: ChatInput(
          onCancelReply: () {},
          chatId: chatId,
          otherUserId: '666350dkkfkf',
        ),
      ),
      body: Stack(
        children: [
          ChatPageBody(
            onReply: (msg) {
              // replyMessage.value = msg;
            },
            onBottomDrag: (val) {
              // showAminateButtom.value = val;
            },
            userId: HiveStorage.userId,
            otherUserId: '666350dkkfkf',
            chatId: chatId,
          ),
        ],
      ),
    );
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ExitButton(
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: context.colorScheme.primary,
              size: 24.sp,
            ),
          ),
          10.sW,
          CircleAvatar(
            radius: 22.r,
            backgroundImage: AssetImage(ImageAssets.userImage),
          ),
          10.sW,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width * 0.45),
                child: Text(
                  'Amara Culture Hub',
                  style: context.body16Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 3.sH,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width * 0.45),
                child: Text(
                  'amaraculturehub',
                  style: context.body14Light.copyWith(
                    color: context.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            showSheet(context, child: ChatActions());
          },
          child: SvgPicture.asset(IconAssets.dashIcon),
        ),
        14.sW,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
