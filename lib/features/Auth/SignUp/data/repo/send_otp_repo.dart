import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';

abstract class SendOtpRepo {
  Future<Either<Failure, OtpModel>> sendOtp(RegisterModel registerModel);
}
