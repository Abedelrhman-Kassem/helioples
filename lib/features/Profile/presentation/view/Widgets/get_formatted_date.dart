import 'package:easy_localization/easy_localization.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

String getFormattedDate(DateTime? dateTime) {
  if (dateTime == null) return "";
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

  if (date == today) {
    return LocaleKeys.alerts_screen_Today.tr();
  } else if (date == yesterday) {
    return "Yesterday";
  } else {
    return DateFormat('d/M').format(dateTime);
  }
}
