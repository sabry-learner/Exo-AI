import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';

class AlredyHaveanAcunt extends StatelessWidget {
  const AlredyHaveanAcunt({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(Routes.logInView);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 120, 119, 119),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,)
              ],
            ),
          );
  }
}