import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';

class CoustemActiveModel extends StatefulWidget {
  const CoustemActiveModel({super.key});

  @override
  State<CoustemActiveModel> createState() => _CoustemActiveModelState();
}

class _CoustemActiveModelState extends State<CoustemActiveModel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Model Active",
          style: AppTextStyle.poppinsow300siz16.copyWith(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp, // نص متجاوب
          ),
        ),
        SizedBox(width: 6.w), // متجاوب
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 7.w, // متجاوب
              height: 7.h, // متجاوب
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(_animation.value),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(_animation.value),
                    blurRadius: 5.r, // متجاوب
                    spreadRadius: 2.r, // متجاوب
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
