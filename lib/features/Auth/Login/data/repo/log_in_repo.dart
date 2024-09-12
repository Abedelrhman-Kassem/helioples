import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/user.dart';

abstract class LogInRepo
{
  Future<Either<Failure,String>> signIn(String phone);
}