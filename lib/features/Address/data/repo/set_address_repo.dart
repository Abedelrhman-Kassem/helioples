import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';

abstract class SetAddressRepo {
  Future<Either<Failure, String>> setAddress({
    required double long,
    required double lat,
    required String locationStr,
    required String buildingNo,
    required String floor,
    required String street,
    required String department,
  });
}
