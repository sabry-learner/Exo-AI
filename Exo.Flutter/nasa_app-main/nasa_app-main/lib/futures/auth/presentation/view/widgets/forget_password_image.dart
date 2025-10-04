import 'package:flutter/material.dart';
import 'package:nasa_app/core/resources/app_assets.dart';

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 235,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesPlant),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
