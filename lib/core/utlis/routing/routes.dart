import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/loginpage.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/home_layout.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/intro_screen.dart';
import 'package:negmt_heliopolis/features/PageNotFound/presentation/view/page_not_found_screen.dart';

class AppRouter {
  Route generate(RouteSettings settings) {
    switch (settings.name) {
      case intialRoute:
        return MaterialPageRoute(builder: (context) => const IntroScreen());

      case introScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());

      case homeLayout:
        return MaterialPageRoute(builder: (context) => const HomeLayout());

      case signInScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case signUpScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const PageNotFoundScreen());
    }
  }
}
