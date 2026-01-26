import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

import 'package:negmt_heliopolis/core/utlis/notifiers/subscription_notifier.dart';

class NotificationButtonControlled extends StatefulWidget {
  final bool isnotification;
  final String productId;
  final void Function() addNotiOrRemoveNoti;
  const NotificationButtonControlled({
    super.key,
    required this.isnotification,
    required this.productId,
    required this.addNotiOrRemoveNoti,
  });

  @override
  NotificationButtonControlledState createState() =>
      NotificationButtonControlledState();
}

class NotificationButtonControlledState
    extends State<NotificationButtonControlled>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offsetAnim;

  final double moveDistance = 15.0;
  final SubscriptionNotifier _subscriptionNotifier = SubscriptionNotifier();

  @override
  void initState() {
    super.initState();
    _subscriptionNotifier.addListener(_subscriptionListener);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _offsetAnim = Tween<double>(
      begin: 0.0,
      end: -moveDistance,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.isnotification) {
      _controller.forward();
    }
  }

  void _subscriptionListener() {
    if (_subscriptionNotifier.productId == widget.productId) {
      if (_subscriptionNotifier.isSubscribed) {
        if (_controller.status != AnimationStatus.completed &&
            _controller.status != AnimationStatus.forward) {
          _controller.forward();
        }
      } else {
        if (_controller.status != AnimationStatus.dismissed &&
            _controller.status != AnimationStatus.reverse) {
          _controller.reverse();
        }
      }
    }
  }

  @override
  void dispose() {
    _subscriptionNotifier.removeListener(_subscriptionListener);
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_controller.status == AnimationStatus.dismissed) {
      // print("AnimationStatus.dismissed");
      _controller.forward();
    } else if (_controller.status == AnimationStatus.completed) {
      // print("AnimationStatus.completed");
      _controller.reverse();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final bool filled = _controller.value > 0.5;
        return GestureDetector(
          onTap: () {
            widget.addNotiOrRemoveNoti();
            _onTap();
          },
          child: Transform.translate(
            offset: Offset(_offsetAnim.value, 0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.mainColor.withValues(alpha: filled ? 0.1 : 0),
              ),
              padding: const EdgeInsets.all(5),
              child: svgIcon(
                path: !filled
                    ? 'assets/svg_icons/notification2.svg'
                    : 'assets/svg_icons/notification3.svg',
                width: !filled ? 35 : 40,
                height: !filled ? 35 : 40,
                color: MyColors.mainColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
