import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/extensions/extensions.dart';

class SettingsPrivacyPage extends HookConsumerWidget {
  const SettingsPrivacyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: cs.onSurface),
        ),
        title: Text("Settings and privacy", style: context.title20),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        children: [
          _sectionHeader("Account"),
          _settingsTile(Icons.person_outline, "Account information", () {
            // TODO: navigate
          }),
          _settingsTile(Icons.lock_outline, "Password", () {
            // TODO: navigate
          }),
          _settingsTile(Icons.shield_outlined, "Privacy", () {
            // TODO: navigate
          }),
          Divider(
            height: 30.h,
            thickness: 8,
            color: cs.surfaceContainerHighest,
          ),

          _sectionHeader("Profile"),
          _settingsTile(Icons.person_off_outlined, "Deactivate account", () {
            // TODO: navigate
          }),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Log out", style: TextStyle(color: Colors.red)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _settingsTile(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
