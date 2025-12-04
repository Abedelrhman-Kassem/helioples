import 'package:easy_localization/easy_localization.dart';

String trKey(
  String key, {
  Map<String, String>? namedArgs,
}) {
  return key.tr(namedArgs: namedArgs ?? {});
}
