import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';

abstract class AddAddressRepo {
  Future<Either<Failure, String>> addAddress({required Address address});
}
