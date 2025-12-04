import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/features/countries_pages/view/widget/widget_helpe.dart';

class ProfileEmpty extends StatelessWidget {
  const ProfileEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetHelpe(
      title: 'Profile Information',
      buttontext: 'Sign In Now',
      onPressed: () {
        Navigator.of(context).pushNamed(signInScreen);
      },
      subtitlebody:
          'You need sign in to app in order to control your personal information',
      svgpath: SvgPath.noinfo,
      titlebody: 'No Profile Information',
    );
  }
}
