import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

import '../../../data/model/place_suggestion.dart';

class PlaceItem extends StatelessWidget {
  final PlaceSuggestion suggestion;

  const PlaceItem({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var subTitle = suggestion.description
        .replaceAll(suggestion.description.split(',')[0], '');
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsetsDirectional.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              SvgPicture.asset("assets/svg_icons/location_drop_Icon.svg"),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        suggestion.description.split(',')[0],
                        style: Styles.styles14w400NormalBlack,
                      ),
                    ),
                    Text(
                      suggestion.description.split(',')[1],
                      style: Styles.styles12w400black
                          .copyWith(color: const Color(0xFF7E7E7E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          height: 16.h,
          color: const Color(0xFFADADAD),
          indent: 16.w,
          endIndent: 16.w,
        ),
      ],
    );
  }
}
