import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account ?',
          style: TextStyle(
            fontSize: 12.sp, // حجم نص متجاوب
            color: const Color.fromARGB(255, 77, 76, 76),
          ),
        ),
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.signUpView);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 12.sp, // حجم نص متجاوب
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
