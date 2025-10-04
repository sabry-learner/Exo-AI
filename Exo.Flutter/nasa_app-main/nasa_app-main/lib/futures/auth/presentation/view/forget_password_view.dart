import 'package:flutter/material.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/futures/auth/presentation/view/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            'Forget Password',
            style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Pacifico'),
          ),
        ),
        body: ForgetPasswordViewBody(),
      ),
    );
  }
}
