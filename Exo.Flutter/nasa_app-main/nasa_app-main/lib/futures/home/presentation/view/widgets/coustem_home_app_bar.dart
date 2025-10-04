import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/home/presentation/view/widgets/coustem_active_model.dart';
import 'package:nasa_app/core/widgets/coustem_app_bar.dart';

class CoustemHomeAppBar extends StatefulWidget {
  const CoustemHomeAppBar({super.key});

  @override
  State<CoustemHomeAppBar> createState() => _CoustemHomeAppBarState();
}

class _CoustemHomeAppBarState extends State<CoustemHomeAppBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoustemAppBar(
          titel: 'Exoplanet Classification \nDashboard',
          subTitel: 'Real-time analysis of Kepler telescope transit data',
        ),
        CoustemActiveModel(),
         SizedBox(height: 8.h),

        Divider(
          color: Colors.grey, // لون الخط
          thickness: 0.5, // سمك الخط
          indent: 0, // مسافة من البداية
          endIndent: 0, // مسافة من النهاية
        ),
        // 🔹 Model Active + دايرة بتنور وتطفي بالراحة
      ],
    );
  }
}
