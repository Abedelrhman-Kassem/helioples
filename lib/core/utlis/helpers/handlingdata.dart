import 'package:negmt_heliopolis/core/utlis/helpers/statusrequest.dart';

Statusrequest handlingData(response) {
  if (response is Statusrequest) {
    return response;
  } else {
    return Statusrequest.success;
  }
}
