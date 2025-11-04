import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';
import 'package:lykluk/core/shared/widgets/bottom_loader.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/modules/chats/data/models/index.dart';
import 'package:lykluk/modules/chats/domain/message_notifier.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/hooks/scroll_hook.dart';

import 'message_bubble.dart';

class ChatPageBody extends HookConsumerWidget {
  final String userId;
  final String otherUserId;
  final String chatId;
  final Function(MessageModel)? onReply;
  final Function(bool)? onBottomDrag;
  const ChatPageBody({
    super.key,
    required this.userId,
    required this.otherUserId,
    required this.chatId,
    this.onReply,
    this.onBottomDrag,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(messagesProvider(chatId));
    final notifier = ref.read(messagesProvider(chatId).notifier);
    final scrollController = usePagination(
      notifier.loadMore,
      notifier.canLoadMore,
      scrollLevel: 0.7,
    );
    // final isBottom = useState(false);
    // // final debouce = useState(Debounce(duration: 1));

    // useEffect(() {
    //   scrollController.addListener(() {
    //     if (scrollController.offset ==
    //         scrollController.position.minScrollExtent) {
    //       if(isBottom.value == false){
    //       log.d('bottom reached');
    //          isBottom.value = true;
    //             onBottomDrag?.call(isBottom.value);
    //       // debouce.value.run(() {
    //       //   isBottom.value = true;
    //       //   onBottomDrag?.call(isBottom.value);
    //       // });
    //       }
    //     }
    //   });
    //   return null;
    // });

    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        // color: context.colorScheme.surface,
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          10.sH,
          asyncItems.when(
            skipError: true,
            data: (data) {
              if (data.dataList.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(IconAssets.chatIcon),
                        20.sH,
                        Text('Welcome', style: context.title20),
                        5.sH,
                        Text(
                          'Let them know you are here',
                          textAlign: TextAlign.center,
                          style: context.body16,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                flex: 3,
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 10.h),
                  // shrinkWrap: true,
                  reverse: true,
                  itemCount: data.dataList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.dataList.length) {
                      return BottomLoader(
                        isLoading: asyncItems.hasValue && asyncItems.isLoading,
                      );
                    } else {
                      final message = data.dataList[index];
                      return Dismissible(
                        key: Key(message.id ?? ''),
                        confirmDismiss: (d) async {
                          return false;
                        },
                        direction:
                            message.sender != userId
                                ? DismissDirection.endToStart
                                : DismissDirection.startToEnd,
                        dismissThresholds: const {
                          DismissDirection.startToEnd: 0.5,
                          DismissDirection.endToStart: 0.5,
                        },
                        onUpdate: (d) {
                          onReply?.call(message);
                        },
                        child: MessageBubble(
                          message: message,
                          isMe: message.sender == userId,
                          onView: () {
                            log.d('view message ${message.id}');
                            // ref
                            //     .read(messageNotifierProvider.notifier)
                            //     .markAsRead(
                            //       messageId: message.id,
                            //       chatId: chatId,
                            //     );
                          },
                        ),
                      );
                    }
                    // create this chat bubble widge
                  },
                ),
              );
            },
            loading:
                () => Expanded(
                  child: Center(
                    child: LoadingWithText(text: 'Loading messages...'),
                  ),
                ),
            error: (error, stackTrace) {
              return Expanded(
                child: Center(
                  child: AppErrorWidget(
                    onRetry: () {
                      ref.invalidate(messagesProvider(chatId));
                    },
                    asyncValue: asyncItems,
                    errorText: error.toString(),
                  ),
                ),
              );
            },
          ),

          // 10.sH,
        ],
      ),
    );
  }
}
