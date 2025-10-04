import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';

class CoustemAppBar extends StatelessWidget {
  const CoustemAppBar({
    super.key,
    required this.titel,
    required this.subTitel,
    context,
  });
  final String titel;
  final String subTitel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              titel,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Text(
          subTitel,
         style: (AppTextStyle.poppinsow300siz16).copyWith(
            color: Colors.grey,
          ),
        ),

        SizedBox(height: 20.h),

         ],
    );
  }
}
