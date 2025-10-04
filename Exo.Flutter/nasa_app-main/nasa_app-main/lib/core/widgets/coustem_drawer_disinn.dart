import 'package:flutter/material.dart';
import 'package:nasa_app/core/resources/app_assets.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';

class CoustemDrawerDisinghn extends StatelessWidget {
  const CoustemDrawerDisinghn({super.key, required this.text});
final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.assetsImagesPlant)),
          ),
        ),
        Text(
          text,
          style: AppTextStyle.pcificow400siz64.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
