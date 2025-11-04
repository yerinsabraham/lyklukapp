import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class TrackingHistory extends StatelessWidget {
   TrackingHistory({super.key});
  final List<TrackingStep> steps = [
    TrackingStep(
      title: "Order Placed",
      subtitle: "Your order has been received",
      date: "Jun 8, 2023 • 10:46 AM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "Order processed",
      subtitle: "Order is being prepared",
      date: "Jun 8, 2023 • 10:46 AM",
      isCompleted: true,
    ),
    TrackingStep(
      title: "Order shipped",
      subtitle: "Package has been shipped from Distribution Center, NY",
      date: "Jun 8, 2023 • 10:46 AM",
    ),
    TrackingStep(
      title: "Out for delivery",
      subtitle: "Package is out for delivery at Distribution Center, NY",
      date: "Jun 8, 2023 • 10:46 AM",
    ),
    TrackingStep(
      title: "Order Delivered",
      subtitle: "Package has been delivered successfully to “customer’s address appears here”",
      date: "Jun 8, 2023 • 10:46 AM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
      color: context.colorScheme.surface,
      borderRadius: BorderRadius.circular(10.r),
      // de
    ),
      child: Column(
        children:[
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking History",
                style: context.title20.copyWith(fontWeight: FontWeight.bold),
              ),
              // const Spacer(),
              Text(
                'TRK-12345678',
                style: context.body12.copyWith(
                  color: Color(AppColors.textColor2),
                ),
              ),
            ],
          ),
          20.sH,
           ...List.generate(steps.length, (index){
           final step = steps[index];
              final isLast = index == steps.length - 1;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          color:
                              step.isCompleted
                                  ? Colors.deepPurple
                                  : Colors.grey.shade200,
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   color:
                          //       step.isCompleted
                          //           ? Colors.deepPurple
                          //           : Colors.grey,
                          //   width: 2,
                          // ),
                        ),
                        child:
                            step.isCompleted
                                ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                )
                                : Icon(CupertinoIcons.clock, size: 15.r,  color: Colors.grey,
                              ),
                      ),
                      if (!isLast)
                        Container(height: 60, width: 2, color: context.colorScheme.onSecondary.withValues(alpha: 0.2)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Step details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style:context.body14.copyWith(
                        
                              color:
                                  step.isCompleted
                                      ? Colors.deepPurple
                                      : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step.subtitle,
                            style:context.body12,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            step.date,
                             style: context.body12,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
        }),
          
        ] 
      ),
    );
  }
}

class TrackingStep {
  final String title;
  final String subtitle;
  final String date;
  final bool isCompleted;

  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.date,
    this.isCompleted = false,
  });
}
