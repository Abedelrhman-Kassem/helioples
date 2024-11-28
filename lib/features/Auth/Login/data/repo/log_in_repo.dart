import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';

abstract class LogInRepo
{
  Future<Either<Failure,String>> signIn(String phone , String password);
}