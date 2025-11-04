import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import '../../../../../core/shared/widgets/shared_widget.dart';
import '../../../../../utils/assets_manager.dart';
import 'order_tracking.dart';




class SellerOrderView extends HookConsumerWidget {
  const SellerOrderView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            ExitButton(
              child: Icon(
                Icons.keyboard_backspace,
                color: context.colorScheme.inversePrimary,
              ),
            ),
            10.sW,
            Text("ORD-002", style: context.title24Bold),
            5.sW,
            Chip(
              side: BorderSide.none,
              label: Text(
                'Ongoing',
                style: context.body12.copyWith(
                  color: Color(0xff2680EB),
                  fontWeight: FontWeight.w500,
                ),
              ),
              color: WidgetStatePropertyAll(
                Color(0xff2680EB).withValues(alpha: 0.1),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
        // toolbarHeight: 100.h,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: context.colorScheme.inversePrimary,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(children: [
          20.sH,
         OrderDetailSummary(),
          20.sH,
          OrderDetailPaymentSummary(),
          20.sH,
          CustomerDetails(),
          20.sH,
          OrderDeliveryDetails(),
          20.sH,
          TrackingHistory(),
          20.sH,
          CustomButton(onTap: (){}, buttonText: 'Mark as completed',),
          40.sH,


          
        ])),
    );
  }
  
}


class OrderDetailPaymentSummary extends StatelessWidget {
  const OrderDetailPaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        // de
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Summary", style: context.body14Bold),
          ListTile(
            title: Text('Sub-total (3 items)', style: context.body14),
            trailing: Text('₦ 500K', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            title: Text("Delivery fees", style: context.body14),
            trailing: Text('₦ 500K', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.colorScheme.onSecondary),
            ),
            title: Text.rich(
              TextSpan(
                text: 'Service fee ',
                style: context.body14,
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      IconAssets.warningIcon,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.onSecondary.withValues(alpha: .4),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: Text('₦ 500K', style: context.body14),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
          ListTile(
            title: Text('Total', style: context.body16Bold),
            trailing: Text('₦ 1.5M', style: context.body16Bold),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            color: context.colorScheme.onSecondary.withValues(alpha: .1),
          ),
  
          
        ],
      ),
    ) ;
  }
}


class OrderDetailSummary extends StatelessWidget {
  const OrderDetailSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        // de
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text('Order Summary'),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 10.h),
            child: Text("Order Summary", style: context.body14Bold),
          ),
          ...List.generate(4, (i) {
            return OrderItem();
          }),
        ],
      ),
    );
  }
}


class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushNamed(Routes.productDetailsRoute, extra: item.product?.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.onSecondary.withValues(alpha: .1),
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
        
                image: DecorationImage(
                  image: AssetImage(ImageAssets.post1mage),
                  fit: BoxFit.cover,
                ),
              ),
              // backgroundImage: AssetImage(ImageAssets.userImage),
            ),
            10.sW,
            Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Amara cream Amara cream Amara cream ",
                  style: context.body10,
                ),
                10.sH,
             
                Text('Qty 35,Sliver', style: context.body10),
       
                10.sH,
                Text("₦ 500,000", style: context.body10.copyWith(fontWeight: FontWeight.w600, color: context.colorScheme.inversePrimary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDeliveryDetails extends StatelessWidget {
  const OrderDeliveryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
       decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        // de
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Delivery details", style: context.body14Bold),
          Tile(
             title: CircleIcon(child: SvgPicture.asset(IconAssets.locationIcon)),
            subtitle: Text('45B Whitesand beach estate, Orchid street, Lekki', style: context.body14),
          ),
          10.sH,
           Tile(
             title: CircleIcon(child: SvgPicture.asset(IconAssets.storeIcon)),
             subtitle: Text('Please be careful with the packages', style: context.body14),
           ),
          10.sH,
          Tile(
             title: CircleIcon(child: SvgPicture.asset(IconAssets.deliveryCarIcon)),
              subtitle: Row(
              children: [
                Image.asset(ImageAssets.boltImage, height: 20.h, width: 20.w),
                Text('Bolt Delivery', style: context.body14),
              ],
            ),

          ),
           

        ],
      ),
    );
  }
}


class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        // de
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer details", style: context.body14Bold),
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text('Name', style: context.body12),
            subtitle: Text('John Doe', style: context.body14),
            // trailing: ,
          ),
          10.sH,
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text('Email', style: context.body12),
            subtitle: Text('john.doe@gmail.com', style: context.body14),
          ),
          10.sH,
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text('Phone', style: context.body12),
            subtitle: Text('08012345678', style: context.body14),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Widget?  title;
  final Widget?  subtitle;
  const Tile({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title!= null) title?? SizedBox.shrink(),
        if(subtitle!= null) subtitle ?? SizedBox.shrink(),
      ],
    );
  }
}
