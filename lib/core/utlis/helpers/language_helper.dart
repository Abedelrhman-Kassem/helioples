import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> changeLocal(BuildContext context, String langCode) async {
  context.setLocale(Locale(langCode));
  Get.updateLocale(Locale(langCode));
}

String getLocale(BuildContext context) {
  return context.locale.languageCode;
}

bool isRtl(BuildContext context) {
  return getLocale(context) == 'ar';
}

String detectLangFromQuery(String query) {
  final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  if (hasArabic) {
    return 'ar';
  } else {
    return 'en';
  }
}
