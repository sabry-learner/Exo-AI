import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/coustem_auth_disighin.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/cooustem_sin_up_form.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/alredy_have_an_account.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sign_up_bloc_listener.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // متجاوب
      children: [
        SizedBox(height: 40.h), // متجاوب
        CoustemAuthDighin(
          text: 'Sign Up',
        ), // يجب تعديل النصوص داخل CoustemAuthDighin لتكون متجاوبة
        SizedBox(height: 10.h),
        CoustemSinUpForm(), // يجب تعديل الحقول والأزرار داخلها لتكون متجاوبة
        AlredyHaveanAcunt(), // تأكد من استخدام .sp للنصوص داخلها
        SignUpBlocListener(),
      ],
    );
  }
}
