import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:nasa_app/core/widgets/coustem_text_form_filed.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            'Write your email address and we will send you a link to reset your password',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          CoustemTextFormFailed(
            hent: 'You@gmail.com',
            leble: 'Email Address',
          ),
          Spacer(),
          CoustemElevetedBoutten(
            text: 'Send',
            onPressed: () {},
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
