import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/futures/result/presentation/view/widgets/coustem_action_boutten.dart';

class CoustemAppBarBoutten extends StatelessWidget {
  const CoustemAppBarBoutten({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center
      ,
      children: [
        // زر Export Results
        CustomActionButton(
          text: 'Export Results',
          icon: Icons.download,
          color: Colors.blue.shade700,
          onPressed: () {
            print("Export Results Pressed!");
          },
        ),

        SizedBox(width: 16.w), // المسافة متجاوبة

        // زر Share Report
        CustomActionButton(
          text: 'Share Report',
          icon: Icons.share,
          color: Colors.deepPurple,
          onPressed: () {
            print("Share Report Pressed!");
          },
        ),
      ],
    );
  }
}
