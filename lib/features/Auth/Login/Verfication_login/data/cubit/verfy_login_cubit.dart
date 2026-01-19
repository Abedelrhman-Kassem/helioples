import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/core/utlis/services/notifcation_service.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/data/cubit/verfy_login_states.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/repo/verify_and_register_repo_imp.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';

class VerfyLoginCubit extends Cubit<VerfyLoginStates> {
  final LoginModel? loginModel;
  final VerifyAndRegisterRepoImp verifyLoginRepo;

  VerfyLoginCubit({required this.verifyLoginRepo, required this.loginModel})
    : super(const VerfyLoginStates.initial());
  bool clearText = false;

  // static SignInCubit get(context) => BlocProvider.of(context);

  Future<void> verifyOtpAndLogin(String smsCode) async {
    emit(const VerfyLoginStates.loading());

    final result = await verifyLoginRepo.verifayCode(
      loginModel!.verificationId!,
      smsCode,
    );
    result.fold((failure) => emit(VerfyLoginStates.failure(failure)), (
      status,
    ) async {
      if (loginModel?.data != null) {
        if (loginModel!.data!.token != null) {
          ServicesHelper.saveLocal('token', loginModel!.data!.token!);
        }
      }
      final addressesCtrl = Get.find<AddressesControllerImpl>();
      final authC = Get.find<AuthController>();
      await addressesCtrl.fetchAddresses();
      await NotifcationService.handleLoginTopicSwitch();
      authC.login();
      emit(VerfyLoginStates.success(status));
    });
  }

  void changeClearText() {
    clearText = !clearText;
    emit(const VerfyLoginStates.clearText());
  }
}
