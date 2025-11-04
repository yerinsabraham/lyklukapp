import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class UpdatePaymentPage extends HookConsumerWidget {
  const UpdatePaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardNumberCtrl = useTextEditingController();
    final expDateCtrl = useTextEditingController();
    final cvvCtrl = useTextEditingController();
    final nameCtrl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Update payment method")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Credit/Debit Card", style: context.title20),
              20.sH,
              TextField(
                controller: cardNumberCtrl,
                decoration: const InputDecoration(
                  hintText: "1234 1234 1234 1234",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              10.sH,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expDateCtrl,
                      decoration: const InputDecoration(
                        hintText: "MM/YY",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  10.sW,
                  Expanded(
                    child: TextField(
                      controller: cvvCtrl,
                      decoration: const InputDecoration(
                        hintText: "CVV",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              10.sH,
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  hintText: "Cardholder name",
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              SafeArea(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                  ),
                  child: const Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
