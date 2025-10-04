import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/database/prefs_constants.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/resources/app_assets.dart';
import 'package:nasa_app/core/resources/app_text_style.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/main.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    checkVisited();
  }

  Future<void> checkVisited() async {
    bool isVisit =
        await SharedPrefHelper.getBool(PrefsConstants.onBoarding) ?? false;

    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        context.pushReplacementNamed(Routes.homeView);
      } else {
        isVisit
            ? context.pushReplacementNamed(Routes.logInView)
            : context.pushReplacementNamed(Routes.onBoarding);
      }
    });
  }

  @override
  void dispose() {
    // مهم جدًا عشان يمنع memory leak
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              Assets.assetsImagesSplashImage,
              width: 250.w,
              height: 250.h,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              'ExoAI',
              textAlign: TextAlign.center,
              style: AppTextStyle.poppinsow400siz.copyWith(
                fontSize: 40.sp,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
