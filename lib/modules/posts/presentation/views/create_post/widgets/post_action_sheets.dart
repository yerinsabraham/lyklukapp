import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/helpers/app_sheet.dart';
import 'package:lykluk/utils/router/app_router.dart';

class _SheetHeaderHandle extends StatelessWidget {
  const _SheetHeaderHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Center(
        child: Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }
}

class OptionsSheet extends StatelessWidget {
  const OptionsSheet({
    super.key,
    required this.authorName,
    required this.avatar,
    this.onSave,
    this.onNotInterested,
    this.onToggleIcons,
    this.onCopyLink,
    this.onShareTo,
  });

  final String authorName;
  final ImageProvider avatar;
  final VoidCallback? onSave;
  final VoidCallback? onNotInterested;
  final VoidCallback? onToggleIcons;
  final VoidCallback? onCopyLink;
  final VoidCallback? onShareTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // shrink-wrap under SingleChildScrollView
      children: [
        const _SheetHeaderHandle(),

        // Use shrinkWrap + NeverScrollableScrollPhysics inside app sheet scroll
        ListView(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _OptionTile(
              icon: Icons.bookmark_border,
              label: 'Save',
              onTap: onSave,
            ),
            _OptionTile(
              icon: Icons.hide_source_outlined,
              label: 'Not interested',
              onTap: onNotInterested,
            ),
            _OptionTile(
              icon: Icons.remove_red_eye_outlined,
              label: 'Hide icons',
              onTap: onToggleIcons,
            ),
            _OptionTile(
              icon: Icons.link,
              label: 'Copy link',
              onTap: onCopyLink,
            ),
            _OptionTile(
              icon: Icons.ios_share,
              label: 'Share to',
              onTap: onShareTo,
            ),
            const Divider(height: 16),
            _OptionTile(
              icon: Icons.volume_off_rounded,
              label: 'Mute',
              onTap:
                  () => AppSheet.showMuteConfirmSheet(
                    context,
                    authorName: authorName,
                    avatar: avatar,
                    onMute: () => Navigator.pop(context),
                  ),
            ),
            _OptionTile(
              icon: Icons.block_rounded,
              label: 'Block',
              danger: true,
              onTap:
                  () => AppSheet.showBlockConfirmSheet(
                    context,
                    authorName: authorName,
                    avatar: avatar,
                    onBlock: () {
                      AppRouter.router.pop(); // close block confirm
                      AppSheet.showBlockedResultSheet(
                        context,
                        authorName: authorName,
                        avatar: avatar,
                        onOk: () => Navigator.pop(context),
                      );
                    },
                  ),
            ),
            _OptionTile(
              icon: Icons.flag_outlined,
              label: 'Report',
              danger: true,
              onTap:
                  () => AppSheet.showReportReasonsSheet(
                    context,
                    onDone: () => Navigator.pop(context),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.label,
    this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? const Color(0xFFEF4444) : const Color(0xFF111827);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}

class MuteSheet extends StatelessWidget {
  const MuteSheet({
    super.key,
    required this.authorName,
    required this.avatar,
    required this.onMute,
  });

  final String authorName;
  final ImageProvider avatar;
  final VoidCallback onMute;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // important in AppSheet scroll
      children: [
        const _SheetHeaderHandle(),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: avatar, radius: 32.r),
              10.verticalSpace,
              Text(
                'Mute $authorName',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              10.verticalSpace,
              const _Bulleted(
                line: 'They won’t be notified that you muted them.',
              ),
              18.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onMute,
                      child: const Text('Mute post'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BlockSheet extends StatelessWidget {
  const BlockSheet({
    super.key,
    required this.authorName,
    required this.avatar,
    required this.onBlock,
  });

  final String authorName;
  final ImageProvider avatar;
  final VoidCallback onBlock;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // important in AppSheet scroll
      children: [
        const _SheetHeaderHandle(),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: avatar, radius: 32.r),
              10.verticalSpace,
              Text(
                'Block $authorName',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              14.verticalSpace,
              const _Bulleted(
                line:
                    'They won’t be able to message you or find your profile or content on LykLuk.',
              ),
              8.verticalSpace,
              const _Bulleted(
                line:
                    'No one will see their replies on your posts unless you unblock them.',
              ),
              8.verticalSpace,
              const _Bulleted(
                line: 'They won’t be notified that you blocked them.',
              ),
              18.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onBlock,
                  child: const Text('Block'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BlockedResultSheet extends StatelessWidget {
  const BlockedResultSheet({
    super.key,
    required this.authorName,
    required this.avatar,
    this.onUndo,
    this.onOk,
  });

  final String authorName;
  final ImageProvider avatar;
  final VoidCallback? onUndo;
  final VoidCallback? onOk;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // important in AppSheet scroll
      children: [
        const _SheetHeaderHandle(),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: avatar, radius: 32.r),
              10.verticalSpace,
              Text(
                '$authorName is blocked',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              8.verticalSpace,
              const Text('They won’t be notified that you blocked them.'),
              18.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onUndo ?? () => Navigator.pop(context),
                      child: const Text('Undo'),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onOk ?? () => Navigator.pop(context),
                      child: const Text('Ok'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReportSheet extends StatefulWidget {
  const ReportSheet({super.key, required this.onDone});
  final VoidCallback onDone;

  @override
  State<ReportSheet> createState() => ReportSheetState();
}

class ReportSheetState extends State<ReportSheet> {
  int? selected;

  static const reasons = [
    "I just don’t like it",
    "Bullying or unwanted content",
    "Suicide, self-injury or eating disorders",
    "Violence, hate or exploitation",
    "Selling or promoting restricted items",
    "Nudity or sexual activity",
    "Scam, fraud or spam",
    "False information",
    "Intellectual property",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // important
      children: [
        const _SheetHeaderHandle(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Why are you reporting this post?',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const Divider(height: 1),
        // shrink-wrapped list instead of Expanded
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reasons.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            return RadioListTile<int>(
              value: i,
              groupValue: selected,
              onChanged: (v) => setState(() => selected = v),
              title: Text(reasons[i]),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onDone,
              child: const Text('Done'),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentsSheet extends StatelessWidget {
  const CommentsSheet({super.key, required this.cover, required this.total});
  final String cover;
  final int total;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(12, (i) => i);

    return Column(
      mainAxisSize: MainAxisSize.min, // important
      children: [
        const _SheetHeaderHandle(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: _image(cover, 54.w, 84.h),
              ),
              12.horizontalSpace,
              Text(
                '${_fmtNumber(total)} comments',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Comments list — shrink-wrapped
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 80.h),
          itemCount: items.length,
          itemBuilder: (_, i) => _CommentTile(index: i),
        ),

        const Divider(height: 1),
        const _CommentInputBar(),
      ],
    );
  }

  Widget _image(String src, double w, double h) {
    if (src.startsWith('http')) {
      return Image.network(src, width: w, height: h, fit: BoxFit.cover);
    }
    return Image.asset(src, width: w, height: h, fit: BoxFit.cover);
  }

  String _fmtNumber(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: Colors.grey.shade300,
      ),
      title: Row(
        children: [
          Text(
            'Block Global Roots',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
          6.horizontalSpace,
          Text(
            '• 9m • Author',
            style: TextStyle(color: Colors.grey, fontSize: 11.sp),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello, this is a sample comment to this post, you can make use of this as a comment.',
          ),
          6.verticalSpace,
          Row(
            children: [
              Text(
                'Reply',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
              ),
              14.horizontalSpace,
              Text(
                'View 50 replies',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 18),
          Text('338', style: TextStyle(fontSize: 11.sp)),
        ],
      ),
    );
  }
}

class _CommentInputBar extends StatelessWidget {
  const _CommentInputBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        12.w,
        8.h,
        12.w,
        12.h + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F8),
                borderRadius: BorderRadius.circular(22.r),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Add a comment…',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          10.horizontalSpace,
          const Text('😊 😎 😁', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _Bulleted extends StatelessWidget {
  const _Bulleted({required this.line});
  final String line;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.no_accounts_outlined, size: 18.sp, color: Colors.black54),
        8.horizontalSpace,
        Expanded(child: Text(line)),
      ],
    );
  }
}
