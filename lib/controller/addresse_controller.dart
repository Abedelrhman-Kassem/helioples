import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/features/Address/data/model/address_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo_imp.dart';

abstract class AddressesController extends GetxController {
  Future<void> fetchAddresses();
  Future<void> getChossenAddress();
  Future<int?> getChossenAddressId();
  Future<void> setChossenAddress(int addressId);
  void chaingId(int id);
  String mapFailureToMessage(Failure failure);
}

class AddressesControllerImpl extends AddressesController {
  Address? address;

  GetAddressessImp getAddressessImp = GetAddressessImp(ApiService());

  AddressModel mainAddressModel = AddressModel(address: []);
  bool loading = false;
  String? errorMessage;
  int? addressId;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  @override
  fetchAddresses() async {
    final String? token = await ServicesHelper.getLocal('token');

    if (token == null) {
      errorMessage = 'User not authenticated';
      return;
    }
    loading = false;
    errorMessage = null;
    update();

    try {
      final Either<Failure, AddressModel> res =
          await getAddressessImp.getAddressess();

      res.fold(
        (failure) {
          errorMessage = mapFailureToMessage(failure);
          // print(failure);
        },
        (addressModel) async {
          mainAddressModel = addressModel;
          await getChossenAddress();
        },
      );
    } catch (e) {
      errorMessage = 'Something went wrong';
      // print('fetchAddresses error: $e\n$st');
    } finally {
      loading = false;
      update();
    }
  }

  @override
  mapFailureToMessage(Failure failure) {
    return failure.errorMessage;
  }

  @override
  getChossenAddress() async {
    int? addressId = await getChossenAddressId();

    if (addressId == null) return;

    address = mainAddressModel.address!.firstWhere(
      (element) => element.id == addressId,
      orElse: () => mainAddressModel.address!.first,
    );
    this.addressId = address!.id;
  }

  @override
  getChossenAddressId() async {
    return await CacheHelper.getSharedPreferenceData(key: 'addressId');
  }

  @override
  setChossenAddress(int addressId) async {
    await CacheHelper.saveSharedPreferencesData(
      key: 'addressId',
      value: addressId,
    );

    getChossenAddress();
    update(['ChossenAddressId']);
  }

  @override
  chaingId(int id) {
    addressId = id;
    update(['addressId']);
  }
}
