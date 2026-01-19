import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';

abstract class VerifyAndRegisterRepo {
  Future<Either<String, bool>> verifayCode(
    String verificationId,
    String smsCode,
  );

  Future<Either<Failure, ApiResponse<LoginData>>> signUp(
    RegisterModel registerModel,
  );
}
