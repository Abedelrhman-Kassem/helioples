import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void changeLocal(BuildContext context, String langCode) async {
  context.setLocale(Locale(langCode));
}

String getLocale(BuildContext context) {
  return context.locale.languageCode;
}

bool isRtl(BuildContext context) {
  return getLocale(context) == 'ar';
}
