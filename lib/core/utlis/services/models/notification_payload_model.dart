import 'package:negmt_heliopolis/core/utlis/helpers/keys_helper.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';

enum NavigationRoute {
  none(0),
  product(1),
  offer(2),
  category(3),
  order(4);

  final int value;
  const NavigationRoute(this.value);

  static NavigationRoute fromInt(int value) {
    return NavigationRoute.values.firstWhere(
      (e) => e.value == value,
      orElse: () => NavigationRoute.none,
    );
  }
}

class NotificationPayloadModel {
  final NavigationRoute route;
  final String? targetId;
  final String? eventKey;

  NotificationPayloadModel({required this.route, this.targetId, this.eventKey});

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadModel(
      route: NavigationRoute.fromInt(
        int.tryParse(json['route']?.toString() ?? '0') ?? 0,
      ),
      targetId: json['targetId']?.toString(),
      eventKey: json['eventKey']?.toString(),
    );
  }

  void navigate() {
    switch (route) {
      case NavigationRoute.product:
        if (targetId != null) {
          navigatorKey.currentState?.pushNamed(
            productScreen,
            arguments: {'productId': targetId, 'isFromNoti': true},
          );
        }
        break;
      case NavigationRoute.offer:
        if (targetId != null) {
          navigatorKey.currentState?.pushNamed(
            specialOfferItemScreen,
            arguments: {'id': targetId},
          );
        }
        break;
      case NavigationRoute.category:
        if (targetId != null) {
          navigatorKey.currentState?.pushNamed(
            categoriesScreen,
            arguments: {'categoryId': targetId},
          );
        }
        break;
      case NavigationRoute.order:
        if (targetId != null) {
          navigatorKey.currentState?.pushNamed(
            orderDetailsScreen,
            arguments: {'id': targetId},
          );
        }
        break;
      case NavigationRoute.none:
        break;
    }
  }
}
