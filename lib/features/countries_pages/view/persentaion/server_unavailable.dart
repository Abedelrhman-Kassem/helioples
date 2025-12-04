import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/features/countries_pages/view/widget/widget_helpe.dart';

class ServerUnavailable extends StatelessWidget {
  const ServerUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetHelpe(
      showBackArrow: false,
      title: 'Server Unavailable',
      buttontext: 'Notify me when the service is back',
      onPressed: () {},
      subtitlebody:
          'Our servers are currently down or undergoing maintenance. Please try again later.',
      svgpath: SvgPath.noinfo,
      titlebody: 'Service Temporarily Unavailable',
    );
  }
}
