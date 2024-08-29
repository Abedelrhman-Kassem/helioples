import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view/all_special_offers_screen.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/loginpage.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/maps_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/web%20services/places_web_services.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/set_location_cubit/set_location_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/confirmation_screen.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/notification_screen.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/set_location.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/signup_screen.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/verfication_screen.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/cart_screen.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view/categories_screen.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/home_layout.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/intro_screen.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/liked_screen.dart';
import 'package:negmt_heliopolis/features/PageNotFound/presentation/view/page_not_found_screen.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/product_screen.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/special_offer_item_screen.dart';

class AppRouter {
  Route generate(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case intialRoute:
      case introScreen:
        page = const IntroScreen();
        break;
      case homeLayout:
        page = const HomeLayout();
        break;
      case likedScreen:
        page = const LikedScreen();
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
      case signUp2Screen:
        page = const SignupScreen();
        break;
      case verficationScreen:
        final args = settings.arguments as Map<String, dynamic>;
        page = VerificationScreen(
          phoneNumber: args['phoneNumber'],
        );
        break;
      case confirmationScreen:
        page = const ConfirmationScreen();
        break;
      case setLocationScreen:
        page = BlocProvider(
          create: (BuildContext context) =>
              MapsCubit(MapsRepository(PlacesWebservices())),
          child: const SetLocationScreen(),
        );
        break;
      case notificationScreen:
        page = const NotificationScreen();
        break;

      case categoriesScreen:
        page = const CategoriesScreen();
        break;

      case cartScreen:
        page = const CartScreen();
        break;

      case productScreen:
        page = const ProductScreen();
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
            milliseconds: 300,
          ),
          reverseTransitionDuration: const Duration(
            milliseconds: 300,
          ),
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super
        .buildTransitions(context, animation, secondaryAnimation, child);
  }
}
