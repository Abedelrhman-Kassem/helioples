import 'package:dartz/dartz.dart';

abstract class VerifyLoginRepo {
  Future<Either<String, bool>> verifayCode(
      String verificationId, String smsCode);
}
