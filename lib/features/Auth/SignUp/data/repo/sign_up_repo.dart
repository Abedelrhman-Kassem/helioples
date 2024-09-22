import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/user.dart';

abstract class SignUpRepo
{
  Future<Either<Failure,String>> signUp(User user);
  Future<Either<Failure,String>> setLocation(double long , double lat);
}