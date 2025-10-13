import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Address/data/model/address_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo.dart';

class GetAddressessImp extends GetAddressesReop {
  ApiService apiService;
  GetAddressessImp(this.apiService);

  @override
  Future<Either<Failure, AddressModel>> getAddressess() async {
    AddressModel addressModel = AddressModel.fromJson({});
    try {
      addressModel = AddressModel.fromJson(
        await apiService.get(
          endpoint: 'api/protected/user/get-addressess',
        ),
      );

      return right(addressModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
