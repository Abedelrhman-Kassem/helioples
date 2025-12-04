import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';

class AuthController extends GetxController {
  final RxBool isLogged = false.obs;

  Future<void> checkAuth() async {
    try {
      final String? token = await ApiService.getToken();
      isLogged.value = token != null;
    } catch (e) {
      isLogged.value = false;
    }
  }

  void login() {
    isLogged.value = true;
  }

  void logout() {
    isLogged.value = false;
  }

  void setLogged(bool v) => isLogged.value = v;
}
