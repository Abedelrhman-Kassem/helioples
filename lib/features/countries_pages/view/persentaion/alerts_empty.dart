import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/features/countries_pages/view/widget/widget_helpe.dart';

class AlertsEmpty extends StatelessWidget {
  const AlertsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetHelpe(
      title: 'Alerts',
      buttontext: 'Sign In Now',
      onPressed: () {
        Navigator.of(context).pushNamed(signInScreen);
      },
      subtitlebody:
          'Sign in now to start receiving alerts with offers and likely products by you',
      svgpath: SvgPath.noalert,
      titlebody: 'No Alerts',
    );
  }
}
