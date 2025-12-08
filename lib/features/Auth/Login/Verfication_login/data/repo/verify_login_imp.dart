import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/data/repo/verify_login_repo.dart';

class VerifyAndRegisterRepoImp extends VerifyLoginRepo {
  final ApiService apiService;

  VerifyAndRegisterRepoImp({required this.apiService});
  @override
  Future<Either<String, bool>> verifayCode(
      String verificationId, String smsCode) async {
    try {
      final result = await SendOtpHelper.signInWithSmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return result;
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
}
