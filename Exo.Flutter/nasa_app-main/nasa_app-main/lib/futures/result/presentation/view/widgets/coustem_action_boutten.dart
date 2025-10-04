import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 20.sp, // حجم الأيقونة متجاوب
      ),
      label: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp, // حجم النص متجاوب
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w, // العرض متجاوب
          vertical: 12.h,   // الطول متجاوب
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r), // نصف القطر متجاوب
        ),
        elevation: 5,
      ),
    );
  }
}
