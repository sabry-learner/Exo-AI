import 'package:flutter/material.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';

class ForgetPasswordTitel extends StatelessWidget {
  const ForgetPasswordTitel({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
            child: Text('Forgot Password', style: AppTextStyle.poppinsow400siz),
          );
  }
}