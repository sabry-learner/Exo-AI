import 'package:flutter/material.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/resources/app_assets.dart';
import 'package:nasa_app/core/widgets/coutem_circel_image.dart';

class CoustemUserInfo extends StatelessWidget {
  const CoustemUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // هنا ممكن توديه على صفحة البروفايل
      },
      child: Row(
        children: [
          CoustemCircleImage(urlImage: Assets.assetsImagesPlant),
          const SizedBox(width: 10),
          FutureBuilder(
            future: SharedPrefHelper.getString(
              "username",
            ), // المفتاح اللي خزنت بيه الاسم
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }
              if (snapshot.hasError) {
                return const Text("Error");
              }
              final username = snapshot.data?.toString() ?? "Guest";
              return Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
