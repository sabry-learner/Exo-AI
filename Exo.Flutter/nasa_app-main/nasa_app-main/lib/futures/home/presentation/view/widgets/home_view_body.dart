import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/home/presentation/view/widgets/coustem_home_app_bar.dart';
import 'package:nasa_app/futures/home/presentation/view/widgets/coustem_home_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w), // متجاوب
      child: ListView(
        children: [
          CoustemHomeAppBar(), // تأكد من استخدام ScreenUtil داخل AppBar
          SizedBox(height: 24.h), // متجاوب
          CoustemHomeList(),
          SizedBox(height: 24.h), // متجاوب

            ],
      ),
    );
  }
}
