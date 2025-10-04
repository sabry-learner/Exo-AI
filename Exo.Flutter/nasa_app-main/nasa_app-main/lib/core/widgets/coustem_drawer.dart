import 'package:flutter/material.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/resources/app_colors.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/core/widgets/coustem_user_info.dart';
import 'package:nasa_app/core/widgets/coustem_drawer_disinn.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:restart_app/restart_app.dart'; // للـ Extensions

class CoustemDrawer extends StatelessWidget {
  const CoustemDrawer({super.key});

  void _navigateIfNeeded(BuildContext context, String routeName) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute != routeName) {
      context.pop(); // يقفل Drawer
      context.pushNamedAndRemoveUntil(routeName, (route) => false);
      // ✅ يمسح الـ stack ويخلي الشاشة دي بس
    } else {
      context.pop(); // لو نفس الشاشة → Drawer يتقفل فقط
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primaryColor),
                child: CoustemDrawerDisinghn(text: 'Exio Ai'),
              ),

              // زر Home
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => _navigateIfNeeded(context, Routes.homeView),
              ),

              // زر Upload
              ListTile(
                leading: const Icon(Icons.upload, color: Colors.white),
                title: const Text(
                  "Upload",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => _navigateIfNeeded(context, Routes.uploadView),
              ),

              // زر Result
              ListTile(
                leading: const Icon(
                  Icons.bar_chart_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Result",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => _navigateIfNeeded(context, Routes.resultView),
              ),

              // زر Setting
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text(
                  "Setting",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => _navigateIfNeeded(context, Routes.settingView),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "LogOut",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  // امسح بيانات المستخدم
                  await SharedPrefHelper.clearAllData();

                  // اعمل Restart للتطبيق
                  Restart.restartApp();
                },
              ),
              const Spacer(),
              const CoustemUserInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
