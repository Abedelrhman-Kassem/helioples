import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/features/countries_pages/view/widget/widget_helpe.dart';

class HistoryEmpty extends StatelessWidget {
  const HistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetHelpe(
      title: 'Orders History',
      buttontext: 'Explore Products',
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeLayout, (route) => false);
      },
      subtitlebody:
          'Seems like you got no previous orders with us, you can start shopping now',
      svgpath: SvgPath.noinfo,
      titlebody: 'No Orders History',
    );
  }
}
