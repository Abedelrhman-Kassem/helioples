import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> changeLocal(BuildContext context, String langCode) async {
  context.setLocale(Locale(langCode));
  Get.updateLocale(Locale(langCode));
}

Widget translateData(Widget column, Widget column2) {
  return isArabic() ? column : column2;
}

String getLocale(BuildContext context) {
  return context.locale.languageCode;
}

String getLanguage() {
  return Get.locale?.languageCode ?? 'ar';
}

bool isRtl(BuildContext context) {
  return getLocale(context) == 'ar';
}

bool isArabic() {
  return Get.locale?.languageCode == 'ar';
}

String detectLangFromQuery(String query) {
  final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  if (hasArabic) {
    return 'ar';
  } else {
    return 'en';
  }
}
