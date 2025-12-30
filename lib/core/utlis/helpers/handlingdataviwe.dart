import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/statusrequest.dart';

class Handlingdataviwe extends StatelessWidget {
  final Statusrequest statusrequest;
  final Widget widget;
  final Widget shimmer;

  const Handlingdataviwe({
    super.key,
    required this.statusrequest,
    required this.widget,
    required this.shimmer,
  });

  @override
  Widget build(BuildContext context) {
    switch (statusrequest) {
      case Statusrequest.loading:
        return shimmer;
      // case Statusrequest.noData:
      //   return Center(
      //     child: Lottie.asset(
      //       Lottieassets.nodatalottie,
      //       width: 220,
      //       height: 220,
      //     ),
      //   );
      // case Statusrequest.oflinefailuer:
      //   return Center(
      //     child: Lottie.asset(
      //       Lottieassets.nointernetlottie,
      //       width: 220,
      //       height: 220,
      //     ),
      //   );
      // case Statusrequest.serverfailuer:
      //   return Center(
      //     child: Lottie.asset(
      //       Lottieassets.srverfailuerlottie,
      //       width: 220,
      //       height: 220,
      //     ),
      //   );
      // case Statusrequest.failuer:
      //   return Center(
      //     child: Lottie.asset(
      //       Lottieassets.nodatalottie,
      //       width: 220,
      //       height: 220,
      //     ),
      //   );
      // case Statusrequest.failuerTryAgain:
      //   return Center(
      //     child: Lottie.asset(Lottieassets.tryAgain, width: 220, height: 220),
      //   );
      default:
        return widget;
    }
  }
}
