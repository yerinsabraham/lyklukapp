import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/modules/posts/presentation/views/create_post/widgets/bottom_sheet_wrapper.dart';
import 'package:lykluk/utils/extensions/extensions.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class SortFilterOptionsSheet extends StatefulWidget {
  final String selectedOption;

  const SortFilterOptionsSheet({super.key, required this.selectedOption});

  @override
  // ignore: library_private_types_in_public_api
  _SortFilterOptionsSheetState createState() => _SortFilterOptionsSheetState();
}

class _SortFilterOptionsSheetState extends State<SortFilterOptionsSheet> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  String getSortParam(String title) {
    switch (title) {
      case 'First to Last':
        return 'A-Z';
      case 'Last to First':
        return 'Z-A';
      default:
        return 'Default';
    }
  }

  // Convert actual value to title for restoring selection
  String _getTitleFromValue(String sortValue) {
    switch (sortValue) {
      case 'A-Z':
        return 'First to Last';
      case 'Z-A':
        return 'Last to First';
      default:
        return 'Default';
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedOption = _getTitleFromValue(widget.selectedOption);
    return BottomSheetWrapper(
      title: '',
      hasDrag: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(AppColors.white),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Column(
                children: [
                  _buildOption('Default'),
                  Divider(color: Colors.grey[200]),
                  _buildOption('Last to First'),
                  Divider(color: Colors.grey[200]),
                  _buildOption('First to Last'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title) {
    return ListTile(
      trailing: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Radio<String>(
          value: title,
          // ignore: deprecated_member_use
          groupValue: _selectedOption,
          activeColor: context.colorScheme.primary,
          // ignore: deprecated_member_use
          onChanged: (value) {
            setState(() => _selectedOption = value!);
            Future.delayed(const Duration(milliseconds: 150), () {
              Navigator.pop(context, getSortParam(value!));
            });
          },
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Text(title, style: context.body16Bold),
      ),
      onTap: () async {
        setState(() => _selectedOption = title);
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.pop(context, getSortParam(title));
        });
      },
    );
  }
}
