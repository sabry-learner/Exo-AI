import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/widgets/coustem_app_bar.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/coustem_app_bar_boutten.dart';

class CoustemResultAppBar extends StatelessWidget {
  const CoustemResultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CoustemAppBar(
          titel: 'Classification Results',
          subTitel: 'Analysis results and performance metrics',
        ),
        //SizedBox(height: 10.h),
        CoustemAppBarBoutten(),
        SizedBox(height: 16.h),
      ],
    );
  }
}
