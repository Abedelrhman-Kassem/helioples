import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';

class AuthController extends GetxController {
  final RxBool isLogged = false.obs;

  Future<void> checkAuth() async {
    try {
      final String? token = await ServicesHelper.getLocal('token');
      isLogged.value = token != null;
    } catch (e) {
      isLogged.value = false;
    }
  }

  void login() {
    isLogged.value = true;
  }

  Future<void> logout() async {
    isLogged.value = false;
    await DBHelper.deleteData(table: cartTable);
  }

  void setLogged(bool v) => isLogged.value = v;
}
