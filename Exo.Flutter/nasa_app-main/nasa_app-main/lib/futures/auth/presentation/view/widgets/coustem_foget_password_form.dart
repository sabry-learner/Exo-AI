import 'package:flutter/material.dart';
import 'package:nasa_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:nasa_app/core/widgets/coustem_text_form_filed.dart';

class CoustemFogetPasswordForm extends StatefulWidget {
  const CoustemFogetPasswordForm({super.key});

  @override
  State<CoustemFogetPasswordForm> createState() => _CoustemFogetPasswordFormState();
}

class _CoustemFogetPasswordFormState extends State<CoustemFogetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  bool isLoading = false;

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    // هنا تحط اللوجيك بتاع الـ Reset Password
    await Future.delayed(const Duration(seconds: 2)); // محاكاة API call

    setState(() {
      isLoading = false;
    });

    // لو العملية نجحت
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Go to your email and reset password by link')),
    );

    // بعد النجاح روح لصفحة الـ Sign In
    Navigator.pushReplacementNamed(context, "/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CoustemTextFormFailed(
            leble: 'Email Address',
            hent: 'You@gmail.com',
            onChanged: (val) {
              email = val;
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Email is required";
              }
              if (!val.contains("@")) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          isLoading
              ? const CircularProgressIndicator()
              : CoustemElevetedBoutten(
                  text: 'Reset Password',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await resetPassword();
                    }
                  },
                ),
        ],
      ),
    );
  }
}
