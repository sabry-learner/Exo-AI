import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/di/set_up_get_it.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo_impl.dart';
import 'package:nasa_app/futures/auth/presentation/maneger/sign_up_cubit/sign_up_cubit.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sin_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt<AuthRepoImpl>()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color.fromARGB(255, 22, 11, 55),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w), // متجاوب
              child:
                  SignUpViewBody(), // تأكد من استخدام ScreenUtil داخل Body للأزرار والنصوص
            ),
          ),
        ),
      ),
    );
  }
}
