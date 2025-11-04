import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/core/shared/widgets/shared_widget.dart';
import 'package:lykluk/utils/extensions/extensions.dart';




class ReportPostSheet extends StatelessWidget {
  const ReportPostSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.onSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                height: 8.h,
                width: 100.w,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(children: [
                  ActionTile(
              title: 'I just don’t like it',
              trailing: CustomRadio(groupValue: 0, onTap: (v){}, value: 2, radius: 20.r,),
           
            ),
            ActionTile(
              title: 'Bullying or unwanted content',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Suicide, self-injury or eating disorders',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Violence, hate or exploitation',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Violence, hate or exploitation',
               trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Selling or promoting restricted items',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Nudity or sexual activity',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Scam, fraud or spam',
               trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'False information',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
            ),
            ActionTile(
              title: 'Intellectual property',
              trailing: CustomRadio(
                groupValue: 0,
                onTap: (v) {},
                value: 2,
                radius: 20.r,
              ),
              hasBorder: false,
            ),
              ],),
            ),
            10.sH,
          
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SvgPicture.asset(IconAssets.warningIcon),
                  CircleAvatar(
                    radius: 12.r,
                    backgroundColor:  context.colorScheme.primary.withValues(alpha: 0.2),
                    child: Center(child: Text("!", style: context.title32.copyWith(color: context.colorScheme.primary, fontSize: 13.sp),)),
                  ),
                  10.sW,
                  Expanded(
                    child: Text(
                      'Your report is anonymous. If someone is in immediate danger, please call emergency services!',
                      textAlign: TextAlign.start,
                      style: context.body12.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.sH,
            CustomButton(
              onTap: () {},
              buttonText: 'Done',
              // width: 100.w,
              height: 40.h,
              color: context.colorScheme.primary,
              textColor: context.colorScheme.surface,
            ),
            30.sH,
          ],
        ),
      ),
    );
  }
}
