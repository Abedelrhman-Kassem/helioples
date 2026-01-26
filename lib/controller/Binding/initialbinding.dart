import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/connectivity_controller.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ApiService(), permanent: true);
    // Get.put(CheckMaintenance());
    Get.put(ConnectivityController(), permanent: true);
    Get.put(AddressesControllerImpl(), permanent: true);

    Get.put(AuthController()).checkAuth();
  }
}
