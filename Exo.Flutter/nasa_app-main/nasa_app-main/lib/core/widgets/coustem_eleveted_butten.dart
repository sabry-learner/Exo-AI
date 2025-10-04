import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustemElevetedBoutten extends StatelessWidget {
  const CoustemElevetedBoutten({
    super.key,
    this.onPressed,
    required this.text,
    this.color,
    this.height,
    this.fontSize,
  });

  final void Function()? onPressed;
  final String text;
  final Color? color;
  final double? height;     // ارتفاع متجاوب
  final double? fontSize;   // حجم نص متجاوب

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: height ?? 50.h, // ارتفاع افتراضي 50.h
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  color ?? const Color.fromARGB(255, 74, 57, 226),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r), // متجاوب
                  ),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize ?? 18.sp), // متجاوب
              ),
            ),
          ),
        ),
      ],
    );
  }
}
