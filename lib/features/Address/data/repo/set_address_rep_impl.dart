import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Address/data/repo/set_address_repo.dart';

class SetAddressRepImpl extends SetAddressRepo {
  final ApiService apiService;

  SetAddressRepImpl({required this.apiService});
  @override
  setAddress(
      {required double long,
      required double lat,
      required String locationStr,
      required String buildingNo,
      required String floor,
      required String street,
      required String department}) async {
    try {
      Map<String, dynamic> data = {
        'longitude': long,
        'latitude': lat,
        'locationStr': locationStr,
        'buildingNo': buildingNo,
        'floor': floor,
        'street': street,
        'department': department
      };

      var response = await apiService.post(
          endPoints: 'api/protected/user/add-location', data: data);
      if (response.statusCode == 200) {
        return right(response.data['msg']);
      } else {
        return left(ServerFailure('Failed to set the location'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
