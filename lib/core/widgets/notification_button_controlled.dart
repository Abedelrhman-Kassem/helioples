import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

class NotificationButtonControlled extends StatefulWidget {
  final bool isnotification;
  final void Function() addNotiOrRemoveNoti;
  const NotificationButtonControlled(
      {super.key,
      required this.isnotification,
      required this.addNotiOrRemoveNoti});

  @override
  NotificationButtonControlledState createState() =>
      NotificationButtonControlledState();
}

class NotificationButtonControlledState
    extends State<NotificationButtonControlled>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _offsetAnim;

  final double moveDistance = 20.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _offsetAnim = Tween<double>(begin: 0.0, end: -moveDistance).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    if (widget.isnotification) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_controller.status == AnimationStatus.dismissed) {
      print("AnimationStatus.dismissed");
      _controller.forward();
    } else if (_controller.status == AnimationStatus.completed) {
      print("AnimationStatus.completed");
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
                    width: !filled ? 31 : 35,
                    height: !filled ? 31 : 35,
                    color: MyColors.mainColor)),
          ),
        );
      },
    );
  }
}
