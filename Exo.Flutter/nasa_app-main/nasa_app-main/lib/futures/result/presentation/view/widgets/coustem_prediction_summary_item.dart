import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PredictionSummaryWidget extends StatelessWidget {
  final int count;
  final String label;
  final Color baseColor;
  final IconData icon;

  const PredictionSummaryWidget({
    super.key,
    required this.count,
    required this.label,
    required this.baseColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Color widgetBackgroundColor = const Color(0xFF191632);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: widgetBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: baseColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 40.w),
            ),
            SizedBox(height: 20.h),
            Text(
              NumberFormat.decimalPattern().format(count),
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              style: TextStyle(
                color: baseColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
