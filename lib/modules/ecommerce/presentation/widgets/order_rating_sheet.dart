import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/assets_manager.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

import '../../../../core/shared/widgets/shared_widget.dart';

class OrderRatingSheet extends HookConsumerWidget {
  const OrderRatingSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset(ImageAssets.post2mage)
              CircleAvatar(
                radius: 50.r,
                backgroundImage: AssetImage(ImageAssets.post2mage),
              ),
              Text('Rate your experience', style: context.title32),
              AppRatingBar(onRatingUpdate: (c) {}, iconSize: 50.r, initial: 5),
              10.sH,
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.r),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(child: Text('Amazing ')),
              ),
              10.sH,
              AnswerChoice(text: 'What stood out to you about the item?'),
              10.sH,
              AnswerChoice(text: 'What stood out to you about the delivery?'),
              20.sH
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerChoice extends HookConsumerWidget {
  final String text;
  const AnswerChoice({super.key, required this.text});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(text, style: context.body16Bold),
          10.sH,
          Wrap(
            spacing: 10.w,
            children: List.generate(_answerTags.length, (i) {
              return Chip(
                label: Text(_answerTags[i], style: context.body14Light),
                side: BorderSide(color: context.colorScheme.onTertiaryFixed, width: 1.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

const _answerTags = [
  "Communication",
  "Hygiene",
  "Polite",
  "Clean",
  "Friendly",
  "Helpful",
  "Packaging",
  "Handoff",
  "Drives carefully",
  "Professionalism",
  "Composure",
  "Customer service",
];
