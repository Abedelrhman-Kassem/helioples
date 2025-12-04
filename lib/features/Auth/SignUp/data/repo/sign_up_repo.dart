import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';

abstract class SignUpRepo {
  // Future<Either<Failure, Map<String, dynamic>>> signUp(
  //     RegisterModel registerModel);
  Future<Either<Failure, String>> setLocation(double long, double lat);
}
