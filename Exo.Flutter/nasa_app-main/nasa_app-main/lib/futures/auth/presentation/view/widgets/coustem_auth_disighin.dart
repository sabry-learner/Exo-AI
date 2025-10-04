import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_assets.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';

class CoustemAuthDighin extends StatefulWidget {
  const CoustemAuthDighin({super.key, required this.text});
  final String text;

  @override
  State<CoustemAuthDighin> createState() => _CoustemAuthDighinState();
}

class _CoustemAuthDighinState extends State<CoustemAuthDighin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward(); // تشغيل الأنيميشن
  }

  @override
  void dispose() {
    _controller.dispose(); // عشان ميسيبش memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            height: 200.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.assetsImagesPlant),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        FadeTransition(
          opacity: _fadeAnimation,
          child: Text(
            widget.text,
            style: AppTextStyle.pcificow400siz64.copyWith(
              fontSize: 40.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
