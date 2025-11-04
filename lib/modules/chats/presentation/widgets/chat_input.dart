import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/chats/data/models/index.dart';
import 'package:lykluk/modules/chats/domain/message_notifier.dart';
import 'package:lykluk/modules/chats/presentation/widgets/media_choice_sheet.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/storage/local_storage.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class ChatInput extends HookConsumerWidget {
  final String otherUserId;
  final String chatId;
  final MessageModel? replyMessage;
  final VoidCallback? onCancelReply;
  const ChatInput({
    super.key,
    required this.otherUserId,
    required this.chatId,
    this.replyMessage,
    this.onCancelReply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isTyping = useState(false);
    // final messages = ref.watch(messagesProvider(chatId)).valueOrNull;

    void onTyping() {
      isTyping.value = controller.text.isNotEmpty;
    }

    useEffect(() {
      controller.addListener(onTyping);
      return () => controller.removeListener(onTyping);
    }, [controller]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (replyMessage != null)
          ReplyMsgTile(reply: replyMessage!, onCancel: onCancelReply),
        Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            constraints: BoxConstraints(
              minHeight: 50.h,
              // maxHeight: 100.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Visibility(
                //   visible: isTyping.value &&
                //       messages != null &&
                //       messages.dataList.isNotEmpty,
                //   child: TypingSuggestions(
                //     onTap: (s) {
                //       if (s == null) return;
                //       controller.clear();
                //       controller.text = s;
                //     },
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomField(
                        // height: 50.h,
                        hasBorder: true,
                        controller: controller,
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        hintTextsize: 13.sp,
                        textSize: 14.sp,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        maxLines: null,
                        borderRadius: 30.r,
                        borderColor: context.colorScheme.surface,
                        hintText: 'Type your message',
                        textCapitalization: TextCapitalization.sentences,
                        fillColor: context.colorScheme.surface,
                        hintColor: context.colorScheme.onTertiaryFixed,
                        suffixWidget: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // final res =
                                  //     await chooseImageBottomSheet(context);
                                  // if (res != null) {
                                  //   ref
                                  //       .read(messageNotifierProvider.notifier)
                                  //       .sendMessage(
                                  //         chatId: chatId,
                                  //         message: res,
                                  //         type: MessageType.image,
                                  //         userId: LocalStorage.userId,
                                  //         // userId: '1332i3i3i'
                                  //       );
                                  // }
                                },
                                child: SvgPicture.asset(
                                  // IconAssets.galleryIcon,
                                  IconAssets.mircophoneIcon,
                                  width: 20.w,
                                ),
                              ),
                              4.sW,
                              GestureDetector(
                                onTap: () {
                                  showMediaChoice(context);
                                },
                                child: SvgPicture.asset(
                                  IconAssets.plusIcon,
                                  width: 20.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onFieldSubmitted: (v) {
                          if (v.isEmpty) return;
                          ref
                              .read(messageNotifierProvider.notifier)
                              .sendMessage(
                                chatId: chatId,
                                message: v,
                                type: MessageType.text,
                                userId: HiveStorage.userId,
                                // userId: '1332i3i3i'
                              );

                          controller.clear();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),

                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: context.colorScheme.primaryFixed,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        ref
                            .read(messageNotifierProvider.notifier)
                            .sendMessage(
                              chatId: chatId,
                              message: controller.text.trimRight(),
                              type: MessageType.text,
                              userId: HiveStorage.userId,
                              // userId: '1332i3i3i'
                            );

                        controller.clear();
                        FocusScope.of(context).unfocus();
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: SvgPicture.asset(IconAssets.sendIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                20.sH,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showMediaChoice(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Color(AppColors.backgroundColor),
      builder: (context) => MediaChoiceSheet(),
    );
  }
}

class TypingSuggestions extends StatelessWidget {
  final Function(String?)? onTap;
  const TypingSuggestions({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final suggestion = ["✋", "Hello", "How are you", "Nice to meet you!"];
    return Wrap(
      // spacing: 4.w,
      alignment: WrapAlignment.center,
      children: List.generate(suggestion.length, (i) {
        final s = suggestion[i];
        return GestureDetector(
          onTap: () {
            onTap?.call(s);
          },
          child: Chip(
            backgroundColor: context.colorScheme.primary.withValues(alpha: .06),
            // padding: const EdgeInsets.all(0.4),
            side: BorderSide.none,
            shape: const StadiumBorder(),
            label: Text(
              s,
              style: context.body12.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ReplyMsgTile extends HookConsumerWidget {
  final MessageModel? reply;
  final VoidCallback? onCancel;
  const ReplyMsgTile({super.key, this.reply, this.onCancel});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (reply?.type) {
      MessageType.text => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.colorScheme.primaryFixed,
              width: 1.w,
            ),
            left: BorderSide(color: context.colorScheme.primary, width: 3.w),
          ),
          // borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width * 0.8),
              child: Text('', style: context.body14Bold),
            ),
            // 2.sH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: context.width * 0.85),
                  child: Text(
                    "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.body12,
                  ),
                ),
                GestureDetector(
                  onTap: onCancel,
                  child: Icon(
                    CupertinoIcons.clear_circled,
                    color: context.colorScheme.error,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      MessageType.image => SizedBox.shrink(),
      MessageType.video => SizedBox.shrink(),
      MessageType.audio => SizedBox.shrink(),
      MessageType.file => SizedBox.shrink(),
      _ => SizedBox.shrink(),
    };
  }
}
