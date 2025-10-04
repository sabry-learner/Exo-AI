import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustemSaveTemplate extends StatelessWidget {
  CoustemSaveTemplate({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.black.withOpacity(0.4),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              color: Colors.white.withOpacity(0.8),
              size: 22.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              'Save as Template',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
