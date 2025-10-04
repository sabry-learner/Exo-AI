import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/core/database/my_cache_helper.dart';
import 'package:nasa_app/core/database/prefs_constants.dart';
import 'package:nasa_app/core/functions/navigate_extension.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:nasa_app/futures/on_bording/data/model/on_bording_model.dart';
import 'package:nasa_app/futures/on_bording/presentation/view/widgets/on_bording_view_body.dart';

class OnBordingView extends StatefulWidget {
  const OnBordingView({super.key});

  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  final PageController _controller = PageController(initialPage: 0);
  int curintIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w), // متجاوب
          child: Column(
            children: [
              Expanded(
                child: OnBordingViewBody(
                  controller: _controller,
                  onPageChanged: (index) {
                    SharedPrefHelper.setData(PrefsConstants.onBoarding, true);
                    setState(() {
                      curintIndex = index;
                    });
                  },
                ),
              ),
              curintIndex == onBordingData.length - 1
                  ? Column(
                      children: [
                        CoustemElevetedBoutten(
                          text: 'Create Account',
                          onPressed: () {
                            context.pushNamed(Routes.signUpView);
                          },
                          height: 50.h, // إضافة ارتفاع متجاوب
                          fontSize: 18.sp, // حجم نص متجاوب
                        ),
                        SizedBox(height: 12.h),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(Routes.logInView);
                          },
                          child: Text(
                            'LogIn Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp, // حجم نص متجاوب
                            ),
                          ),
                        ),
                      ],
                    )
                  : CoustemElevetedBoutten(
                      text: 'Next',
                      onPressed: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceIn,
                        );
                      },
                      height: 50.h,
                      fontSize: 18.sp,
                    ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
