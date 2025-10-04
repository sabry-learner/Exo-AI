import 'package:flutter/material.dart';

class FogetPasswordSubTitel extends StatelessWidget {
  const FogetPasswordSubTitel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter your registered email below to receive\npassword reset instruction',
      style: TextStyle(fontSize: 10, color: Colors.grey),
      textAlign: TextAlign.center,
    );
  }
}
