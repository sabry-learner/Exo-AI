import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';
import 'package:nasa_app/futures/on_bording/data/model/on_bording_model.dart';

class OnBordingViewBody extends StatelessWidget {
  OnBordingViewBody({super.key, required this.controller, this.onPageChanged});

  final Function(int)? onPageChanged;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: controller,
      itemCount: onBordingData.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, indx) {
        return Column(
          children: [
            SizedBox(height: 20.h), // متجاوب
            Container(
              height: 280.h, // متجاوب
              width: 370.w,  // متجاوب
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onBordingData[indx].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50.h), // بدل MediaQuery استخدمنا ارتفاع متجاوب
            Text(
              onBordingData[indx].titel,
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinsow400siz.copyWith(
                fontSize: 40.sp, // حجم نص متجاوب
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.h),
            Text(
              onBordingData[indx].subTitel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp, // حجم نص متجاوب
                color: Colors.grey,
              ),
              maxLines: 2,
            ),
          ],
        );
      },
    );
  }
}
