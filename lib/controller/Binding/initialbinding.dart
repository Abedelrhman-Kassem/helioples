import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/connectivity_controller.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';

class Initialbinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(AddressesControllerImpl(), permanent: true);
    Get.put(ConnectivityController(), permanent: true);
    // Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    final authC = Get.put(AuthController());
    await authC.checkAuth();
  }
}
