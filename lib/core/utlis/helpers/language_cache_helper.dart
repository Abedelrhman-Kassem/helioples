import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';

void changeLocal(BuildContext context, String langCode) async {
  context.setLocale(Locale(langCode));
  await CacheHelper.saveSharedPreferencesData(key: 'langCode', value: langCode);
}

String getLocale(BuildContext context) {
  return context.locale.languageCode;
}

bool isRtl(BuildContext context) {
  return getLocale(context) == 'ar';
}
