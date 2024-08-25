import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view/all_special_offers_screen.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/loginpage.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/home_layout.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/intro_screen.dart';
import 'package:negmt_heliopolis/features/PageNotFound/presentation/view/page_not_found_screen.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/special_offer_item_screen.dart';

class AppRouter {
  Route generate(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case intialRoute:
      case introScreen:
      case signUpScreen:
        page = const IntroScreen();
        break;
      case homeLayout:
        page = const HomeLayout();
        break;
      case signInScreen:
        page = const LoginScreen();
        break;
      case specialOfferItemScreen:
        page = const SpecialOfferItemScreen();
        break;
      case allspecialOffersScreen:
        page = const AllSpecialOffersScreen();
        break;
      default:
        page = const PageNotFoundScreen();
        break;
    }

    return _CustomPageRouteBuilder(page: page);
  }
}

// THIS CODE TO ANIMATE THE NAVIGATION AND CHANGE THE SYSTEMLAYOUT COLOR ABOVE THE APPBAR

class _CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget page;

  _CustomPageRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(
            milliseconds: 600,
          ),
          reverseTransitionDuration: const Duration(
            milliseconds: 600,
          ),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    bool hasAppBar = false;
    if (child is Scaffold && child.appBar != null) {
      hasAppBar = true;
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: hasAppBar ? Colors.white : Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return super
        .buildTransitions(context, animation, secondaryAnimation, child);
  }
}

// THIS CODE TO CHANGE THE SYSTEMOVERLAY ABOVE THE APPBAR IN EVERY NAVIGATE

// class _CustomPageRouteBuilder extends MaterialPageRoute {
//   _CustomPageRouteBuilder({required Widget page}) : super(builder: (_) => page);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation, Widget child) {

//     bool hasAppBar = false;
//     if (child is Scaffold && child.appBar != null) {
//       hasAppBar = true;
//     }

//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: hasAppBar ? Colors.white : Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.dark,
//       ),
//     );

//     return super
//         .buildTransitions(context, animation, secondaryAnimation, child);
//   }
// }
