import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/repo/verify_and_register_repo.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/cubit/verfy_and_register_states.dart';

class VerfyAndRegisterCubit extends Cubit<VerfAndRegisterStates> {
  final OtpModel otpModel;
  final VerifyAndRegisterRepo verifyAndRegisterRepo;

  VerfyAndRegisterCubit(
      {required this.otpModel, required this.verifyAndRegisterRepo})
      : super(VerfAndRegisterInitial());
  bool clearText = false;

  // static SignInCubit get(context) => BlocProvider.of(context);

  Future<void> verifyOtpAndRegister(String smsCode) async {
    emit(VerfOtpLoading());
    log('verificationId: ${otpModel.verificationId}');

    final result = await verifyAndRegisterRepo.verifayCode(
        otpModel.verificationId, smsCode);
    result.fold(
      (failure) => emit(VerfOtpFailure(failure)),
      (status) async {
        emit(VerfOtpSuccess(status));
        await register();
      },
    );
  }

  Future<void> register() async {
    emit(RegisterLoading());
    final result = await verifyAndRegisterRepo.signUp(otpModel.registerModel);
    result.fold(
      (failure) => emit(RegisterFailure(failure.errorMessage)),
      (result) async {
        emit(RegisterSuccess(result));
        ServicesHelper.saveLocal('token', result.data);
        final addressesCtrl = Get.find<AddressesControllerImpl>();
        final authC = Get.find<AuthController>();
        await addressesCtrl.fetchAddresses();
        authC.login();
      },
    );
  }

  void changeClearText() {
    clearText = !clearText;
    emit(ClearText());
  }
}
