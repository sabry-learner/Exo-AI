import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/di/set_up_get_it.dart';
import 'package:nasa_app/futures/auth/data/repo/auth_repo_impl.dart';
import 'package:nasa_app/futures/auth/presentation/maneger/sign_in_cubit/sign_in_cubit.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingInCubit(getIt<AuthRepoImpl>()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 11, 55),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w), // متجاوب
            child:
                SignInViewBody(), // استخدم ScreenUtil داخل LogInViewBody للأزرار والنصوص
          ),
        ),
      ),
    );
  }
}
