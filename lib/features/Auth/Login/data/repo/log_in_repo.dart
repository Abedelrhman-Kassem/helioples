import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';

abstract class LogInRepo {
  Future<Either<Failure, LoginModel>> signIn(String phone);
}
