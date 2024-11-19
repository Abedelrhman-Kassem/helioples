import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/routing/routes.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/cart_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/card_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_delivery_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/checkout_details_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pick_up_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pickup_order_details._screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/pickup_reorder_screen.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/re_order_screen.dart';
import 'package:negmt_heliopolis/features/PageNotFound/presentation/view/page_not_found_screen.dart';

class OrderRouter {
  Route generate(RouteSettings settings) {
    Widget page;
    bool fromRight;

    switch (settings.name) {
      case '/':
        // case cartScreen:
        page = const InitialCartScreen();
        fromRight = false;
        break;

      case checkoutScreen:
        page = const CheckoutScreen();
        fromRight = false;
        break;

      case reOrderScreen:
        page = const ReOrderScreen();
        fromRight = true;
        break;

      case checkoutDetailsScreen:
        page = const CheckoutDetailsScreen();
        fromRight = true;
        break;

      case cardScreen:
        page = const CardScreen();
        fromRight = true;
        break;

      case pickUpScreen:
        page = const PickUpScreen();
        fromRight = true;
        break;

      case pickupOrderDetails:
        page = const PickupOrderDetails();
        fromRight = true;
        break;

      case pickupReorderScreen:
        page = const PickupReorderScreen();
        fromRight = true;
        break;

      default:
        page = const PageNotFoundScreen(
          fromParent: 'From Test',
        );
        fromRight = true;
    }
    return CustomPageRouteBuilder(page: page, fromRight: fromRight);
  }
}
