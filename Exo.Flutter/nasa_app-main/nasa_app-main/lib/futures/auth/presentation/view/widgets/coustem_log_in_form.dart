import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:nasa_app/core/widgets/coustem_text_form_filed.dart';
import 'package:nasa_app/futures/auth/presentation/maneger/sign_in_cubit/sign_in_cubit.dart';

class CustemLogInForm extends StatefulWidget {
  CustemLogInForm({super.key});

  @override
  State<CustemLogInForm> createState() => _CustemLogInFormState();
}

class _CustemLogInFormState extends State<CustemLogInForm> {
  bool isObscurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SingInCubit>().signInFormKey,
      child: Column(
        children: [
          CoustemTextFormFailed(
            leble: 'Email Address',
            hent: 'You@gmail.com',
            controller: context.read<SingInCubit>().emailController,
          ),
          SizedBox(height: 30.h), // متجاوب
          CoustemTextFormFailed(
            leble: 'Password',
            hent: '*********',
            controller: context.read<SingInCubit>().passwordController,

            obscure: isObscurePassword,
            sufixIcon: IconButton(
              onPressed: () {
                isObscurePassword = !isObscurePassword;
                setState(() {});
              },
              icon: isObscurePassword
                  ? Icon(Icons.visibility_off, size: 20.sp)
                  : Icon(Icons.visibility, size: 20.sp),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                context.pushNamed(Routes.forgetPass);
              },
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontSize: 12.sp, // حجم نص متجاوب
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 40.h), // متجاوب
          CoustemElevetedBoutten(
            text: 'Sign In',
            onPressed: () {
              if (context
                  .read<SingInCubit>()
                  .signInFormKey
                  .currentState!
                  .validate()) {
                context.read<SingInCubit>().emitSignInState();
              }
            },
            height: 60.h, // ارتفاع متجاوب
            fontSize: 18.sp, // حجم نص متجاوب
          ),
        ],
      ),
    );
  }
}
