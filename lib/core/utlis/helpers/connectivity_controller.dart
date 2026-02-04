import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/services/checkinternet.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ConnectivityController extends GetxController {
  final RxBool isOnline = true.obs;
  Timer? _timer;
  bool _snackShown = false;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkAndUpdate(),
    );
  }

  Future<void> _checkAndUpdate() async {
    bool online = await checkInternet();
    if (online != isOnline.value) {
      isOnline.value = online;
    }
    _handleSnack(isOnline.value);
  }

  void _handleSnack(bool online) {
    if (!online) {
      if (!_snackShown) {
        _snackShown = true;
        showCustomGetSnack(
          isGreen: false,
          duration: const Duration(minutes: 10),
          text: StringTranslateExtension(
            LocaleKeys.connectivity_no_internet,
          ).tr(),
        );
      }
    } else {
      if (_snackShown) {
        if (Get.isSnackbarOpen) {
          try {
            Get.back();
          } catch (e) {
            debugPrint('Error closing connectivity snackbar: $e');
          }
        }
        _snackShown = false;
        showCustomGetSnack(
          isGreen: true,
          text: StringTranslateExtension(
            LocaleKeys.connectivity_connection_restored,
          ).tr(),
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
