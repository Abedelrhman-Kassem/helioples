import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/connectivity_controller.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddressesControllerImpl(), permanent: true);
    Get.put(ConnectivityController(), permanent: true);
  }
}
