import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/trkey_helper.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

enum ValidateInput { username, phoneNumber }

vlidateInPut({
  required String val,
  required int min,
  required int max,
  ValidateInput? type,
}) {
  if (val.isEmpty) {
    return trKey(LocaleKeys.validation_empty_error);
  }
  if (type == ValidateInput.username) {
    if (!GetUtils.isUsername(val)) {
      return trKey(LocaleKeys.validation_invalid_username);
    }
  }

  if (type == ValidateInput.phoneNumber) {
    if (!GetUtils.isPhoneNumber(val)) {
      return trKey(LocaleKeys.validation_invalid_phone);
    }
  }
  if (val.length < min) {
    return trKey(
      LocaleKeys.validation_too_short,
      namedArgs: {"min": min.toString()},
    );
  }
  if (val.length > max) {
    return trKey(
      LocaleKeys.validation_too_long,
      namedArgs: {"max": max.toString()},
    );
  }
}
