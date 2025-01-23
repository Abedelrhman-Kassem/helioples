import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/address_model.dart';

abstract class GetAddressesReop {
  Future<Either<Failure, AddressModel>> getAddressess();
}
