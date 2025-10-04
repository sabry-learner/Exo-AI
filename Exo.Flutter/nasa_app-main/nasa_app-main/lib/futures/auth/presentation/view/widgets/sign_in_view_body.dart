import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/coustem_auth_disighin.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/coustem_log_in_form.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/dont_have_account.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sign_in_bloc_listener.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // متجاوب
      child: ListView(
        children: [
          SizedBox(height: 70.h), // متجاوب
          CoustemAuthDighin(text: 'LogIn'),
          SizedBox(height: 25.h),
          CustemLogInForm(),
          SizedBox(height: 5.h),
          DontHaveAccount(),
          SizedBox(height: 5.h),
          SignInBlocListener(),
        ],
      ),
    );
  }
}
