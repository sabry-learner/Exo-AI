import 'package:flutter/material.dart';
import 'package:nasa_app/core/routes/router_transitions.dart';
import 'package:nasa_app/core/routes/routes.dart';
import 'package:nasa_app/futures/auth/presentation/view/forget_password_view.dart';
import 'package:nasa_app/futures/auth/presentation/view/sign_in_view.dart';
import 'package:nasa_app/futures/auth/presentation/view/sign_up_view.dart';
import 'package:nasa_app/futures/home/presentation/view/home_view.dart';
import 'package:nasa_app/futures/result/presentation/view/result_view.dart';
import 'package:nasa_app/futures/setting/presentation/view/setteing_view.dart';
import 'package:nasa_app/futures/upload/data/models/result_argument/result_argument.dart';
import 'package:nasa_app/futures/upload/presentation/view/upload_view.dart';
import 'package:nasa_app/futures/on_bording/presentation/view/on_bording_view.dart';
import 'package:nasa_app/futures/splash/presentation/view/splash_view.dart';

class AppRouter {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBordingView());
      case Routes.logInView:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.forgetPass:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.homeView:
        return RouterTransitions.buildFade(HomeView());
      case Routes.uploadView:
        return RouterTransitions.buildHorizontal(const UploadView());
      case Routes.resultView:
        return RouterTransitions.buildVertical(
          ResultView(resultArguments: settings.arguments as ResultArguments),
        );
      case Routes.settingView:
        return RouterTransitions.buildFade(SettingView());
      default:
        return null;
    }
  }
}
