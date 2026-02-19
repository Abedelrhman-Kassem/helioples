import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(
    RegisterModel registerModel,
  );
  Future<Either<Failure, String>> setLocation(double long, double lat);
}
