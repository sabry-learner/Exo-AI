import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustemStartClassification extends StatelessWidget {
  CoustemStartClassification({super.key, this.onTap});

  final void Function()? onTap;

  // لون ثابت بدل null
  final Color primaryGreen = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(
            colors: [primaryGreen, primaryGreen],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryGreen.withOpacity(0.4),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Text(
              'Start Classification',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
