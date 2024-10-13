import 'package:flutter/material.dart';
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
import 'package:negmt_heliopolis/features/Checkout/presentation/view/card_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_delivery_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_details_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pick_up_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pickup_order_details._screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pickup_reorder_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/re_order_screen.dart';
import 'package:negmt_heliopolis/features/Home_layout/presentation/view/home_layout.dart';
import 'package:negmt_heliopolis/features/Intro/presentation/view/intro_screen.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/liked_screen.dart';
import 'package:negmt_heliopolis/features/PageNotFound/presentation/view/page_not_found_screen.dart';
import 'package:negmt_heliopolis/features/Product/presentation/view/product_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/alerts%20screens/alerts_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/faqs_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/help_center_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/report_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/history%20screens/history_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/history%20screens/order_details_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/profile%20information%20screens/cahnge_information_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/profile%20information%20screens/verfication_changes_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/settings%20screens/settings_screen.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/special_offer_item_screen.dart';

class AppRouter {
  Route generate(RouteSettings settings) {
    Widget page;
    bool fromRight;

    switch (settings.name) {
      case intialRoute:
      case introScreen:
        // page = const TestScreen();
        page = const IntroScreen();
        fromRight = false;
        break;

      case homeLayout:
        page = const HomeLayout();
        fromRight = false;
        break;

      case likedScreen:
        page = const LikedScreen();
        fromRight = true;
        break;

      case signInScreen:
        page = const LoginScreen();
        fromRight = false;
        break;

      case specialOfferItemScreen:
        page = const SpecialOfferItemScreen();
        fromRight = true;
        break;

      case allspecialOffersScreen:
        page = const AllSpecialOffersScreen();
        fromRight = false;
        break;

      case signUpScreen:
        page = const SignupScreen();
        fromRight = true;
        break;

      case cardScreen:
        page = const CardScreen();
        fromRight = true;
        break;

      case verficationScreen:
        final args = settings.arguments as Map<String, dynamic>;
        page = VerificationScreen(
          phoneNumber: args['phoneNumber'],
        );
        fromRight = true;
        break;

      case confirmationScreen:
        page = const ConfirmationScreen();
        fromRight = true;
        break;

      case setLocationScreen:
        page = BlocProvider(
          create: (BuildContext context) =>
              MapsCubit(MapsRepository(PlacesWebservices())),
          child: const SetLocationScreen(),
        );
        fromRight = true;
        break;

      case notificationScreen:
        page = const NotificationScreen();
        fromRight = true;
        break;

      case categoriesScreen:
        page = const CategoriesScreen();
        fromRight = true;
        break;

      case cartScreen:
        page = const CartScreen();
        fromRight = true;
        break;

      case productScreen:
        final args = settings.arguments as Map<String, dynamic>;
        page = ProductScreen(
          productId: args['productId'],
        );
        fromRight = false;
        break;

      case checkoutScreen:
        page = const CheckoutScreen();
        fromRight = false;
        break;

      case cahngeInformationScreen:
        page = const CahngeInformationScreen();
        fromRight = true;
        break;

      case verficationChangesScreen:
        final args = settings.arguments as Map<String, dynamic>;
        page = VerficationChangesScreen(
          phoneNumber: args['phoneNumber'],
        );
        fromRight = true;
        break;

      case historyScreen:
        page = const HistoryScreen();
        fromRight = true;
        break;

      case orderDetailsScreen:
        page = const OrderDetailsScreen();
        fromRight = true;
        break;

      case checkoutDetailsScreen:
        page = const CheckoutDetailsScreen();
        fromRight = true;
        break;

      case alertsScreen:
        page = const AlertsScreen();
        fromRight = true;
        break;

      case settingsScreen:
        page = const SettingsScreen();
        fromRight = true;
        break;

      case helpCenterScreen:
        page = const HelpCenterScreen();
        fromRight = true;
        break;

      case reportScreen:
        page = const ReportScreen();
        fromRight = true;
        break;

      case faqsScreen:
        page = const FaqsScreen();
        fromRight = false;
        break;

      case reOrderScreen:
        page = const ReOrderScreen();
        fromRight = false;
        break;
      case pickUpScreen:
        page = const PickUpScreen();
        fromRight = false;
        break;
      case pickupOrderDetails:
        page = const PickupOrderDetails();
        fromRight = false;
        break;
      case pickupReorderScreen:
        page = const PickupReorderScreen();
        fromRight = false;
        break;

      default:
        page = const PageNotFoundScreen();
        fromRight = true;
        break;
    }

    return _CustomPageRouteBuilder(page: page, fromRight: fromRight);
  }
}

// THIS CODE TO ANIMATE THE NAVIGATION AND CHANGE THE SYSTEMLAYOUT COLOR ABOVE THE APPBAR

class _CustomPageRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final bool fromRight;

  _CustomPageRouteBuilder({
    required this.page,
    required this.fromRight,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = fromRight ? const Offset(1, 0) : const Offset(0, 1);
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
}
