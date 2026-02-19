import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/controller/map/addresse_controller.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/repo/verify_and_register_repo.dart';
import 'package:negmt_heliopolis/features/Auth/auth_controller.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/cubit/verfy_and_register_states.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';

class VerfyAndRegisterCubit extends Cubit<VerfAndRegisterStates> {
  final OtpModel otpModel;
  final VerifyAndRegisterRepo verifyAndRegisterRepo;

  VerfyAndRegisterCubit({
    required this.otpModel,
    required this.verifyAndRegisterRepo,
  }) : super(const VerfAndRegisterStates.initial());
  bool clearText = false;

  // static SignInCubit get(context) => BlocProvider.of(context);

  Future<void> verifyOtpAndRegister(String smsCode) async {
    emit(const VerfAndRegisterStates.verfOtpLoading());

    final result = await verifyAndRegisterRepo.verifayCode(
      otpModel.verificationId,
      smsCode,
    );
    result.fold(
      (failure) =>
          emit(VerfAndRegisterStates.verfOtpFailure(ServerFailure(failure))),
      (status) async {
        emit(VerfAndRegisterStates.verfOtpSuccess(status));
        await register();
      },
    );
  }

  Future<void> register() async {
    emit(const VerfAndRegisterStates.registerLoading());
    final result = await verifyAndRegisterRepo.signUp(otpModel.registerModel);
    result.fold(
      (failure) =>
          emit(VerfAndRegisterStates.registerFailure(failure.errorMessage)),
      (result) async {
        emit(VerfAndRegisterStates.registerSuccess(result));
        if (result.data != null) {
          if (result.data!.token != null) {
            CacheHelper.instance.saveLocal('token', result.data!.token!);
          }
        }
        final addressesCtrl = Get.find<AddressesControllerImpl>();
        final authC = Get.find<AuthController>();
        await addressesCtrl.fetchAddresses();
        authC.login();
      },
    );
  }

  void changeClearText() {
    clearText = !clearText;
    emit(const VerfAndRegisterStates.clearText());
  }
}
