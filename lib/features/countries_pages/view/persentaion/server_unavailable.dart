import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/trkey_helper.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/getx_service/check_mainte_nance.dart';
import 'package:negmt_heliopolis/core/constants/svg_path.dart';
import 'package:negmt_heliopolis/core/utlis/services/awesome/notification_controller.dart';
import 'package:negmt_heliopolis/features/countries_pages/view/widget/widget_helpe.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ServerUnavailable extends StatelessWidget {
  const ServerUnavailable({super.key});

  @override
  Widget build(BuildContext context) {
    String? maintenance = Get.find<CheckMaintenance>().massege;
    log(maintenance.toString());
    NotificationController.initializeListeners();
    return PopScope(
      canPop: false,
      child: WidgetHelpe(
        showBackArrow: false,
        title: trKey(LocaleKeys.maintenance_screen_server_unavailable),
        buttontext: trKey(LocaleKeys.maintenance_screen_notify_me),
        onPressed: maintenance == null ? null : () {},
        subtitlebody: maintenance != null && maintenance.isNotEmpty
            ? null
            : trKey(LocaleKeys.maintenance_screen_default_maintenance_msg),
        svgpath: SvgPath.noinfo,
        titlebody: maintenance != null && maintenance.isNotEmpty
            ? maintenance
            : trKey(
                LocaleKeys.maintenance_screen_service_temporarily_unavailable,
              ),
      ),
    );
  }
}
