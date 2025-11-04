import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/modules/chats/data/models/message_model.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class MessageBubble extends HookConsumerWidget {
  final bool isMe;
  final MessageModel message;
  final VoidCallback? onView;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onView,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (message.type) {
      MessageType.text => TextMessage(
        isMe: isMe,
        message: message,
        onView: onView,
      ),
      MessageType.image => ImageMessage(
        message: message,
        isMe: isMe,
        onView: onView,
      ),
      MessageType.video => SizedBox.shrink(),
      MessageType.audio => SizedBox.shrink(),
      MessageType.file => SizedBox.shrink(),
      _ => SizedBox.shrink(),
    };
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.isMe,
    required this.message,
    this.onView,
  });

  final bool isMe;
  final MessageModel message;
  final VoidCallback? onView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.loose(
                  Size.fromWidth(context.width * 0.7),
                  // maxWidth: context.width * 0.7,
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                  // alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color:
                        isMe
                            ? context.colorScheme.primary
                            : context.colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                      bottomLeft: isMe ? Radius.circular(10.r) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : Radius.circular(10.r),
                    ),
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: message.message,
                      style: context.body14Light.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isMe ? context.colorScheme.surface : null,
                      ),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Icon(
                              Icons.done_all_rounded,
                              size: 15.r,
                              color:
                                  isMe
                                      ? context.colorScheme.surface
                                      : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          //
        ],
      ),
    );
  }
}

class ImageMessage extends HookConsumerWidget {
  final MessageModel message;
  final bool isMe;
  final VoidCallback? onView;
  const ImageMessage({
    super.key,
    required this.message,
    required this.isMe,
    this.onView,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200.h,
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(message.message ?? '')),
            ),
          ),
        ),
      ],
    );
  }
}
