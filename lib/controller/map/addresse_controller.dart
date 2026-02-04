import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/statusrequest.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo_imp.dart';

abstract class AddressesController extends GetxController {
  Future<void> fetchAddresses();
  Future<void> getChossenAddress();
  Future<String?> getChossenAddressId();
  Future<void> setChossenAddress(String addressId);
  void chaingId(String id);
  String mapFailureToMessage(Failure failure);
  Future<void> updateAddress(Address address);
}

class AddressesControllerImpl extends AddressesController {
  Address? address;

  GetAddressessImp getAddressessImp = GetAddressessImp(ApiService());

  AddressModel? mainAddressModel;
  bool loading = false;
  String? errorMessage;
  String? addressId;
  Statusrequest updateAddressesstatusrequest = Statusrequest.none;

  UseOnceAddress? usOneAddress;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  @override
  fetchAddresses() async {
    loading = true;
    final String? token = await ServicesHelper.getLocal('token');
    if (token == null) {
      errorMessage = 'No Address Found';
      loading = false;
      return;
    }
    errorMessage = null;
    update();

    try {
      final Either<Failure, AddressModel> res = await getAddressessImp
          .getAddressess();
      res.fold(
        (failure) {
          errorMessage = mapFailureToMessage(failure);
        },
        (addressModel) async {
          mainAddressModel = addressModel;

          if (await getChossenAddressId() == null &&
              addressModel.address.isNotEmpty) {
            setChossenAddress(addressModel.address.first.id!);
          }
          await getChossenAddress();
          update(['addressId']);
        },
      );
    } catch (e) {
      errorMessage = 'Something went wrong';
    } finally {
      loading = false;
      update(['ChossenAddressId']);
      update();
    }
  }

  @override
  mapFailureToMessage(Failure failure) {
    return failure.errorMessage;
  }

  @override
  getChossenAddress() async {
    String? addressId = await getChossenAddressId();

    if (addressId == null ||
        mainAddressModel == null ||
        mainAddressModel!.address.isEmpty) {
      return;
    }

    address = mainAddressModel!.address.firstWhere(
      (element) => element.id == addressId,
      orElse: () => mainAddressModel!.address.first,
    );
    this.addressId = address!.id;
    update(['ChossenAddressId']);
  }

  @override
  getChossenAddressId() async {
    return await CacheHelper.getSharedPreferenceData(key: 'addressId');
  }

  @override
  setChossenAddress(String addressId) async {
    await CacheHelper.saveSharedPreferencesData(
      key: 'addressId',
      value: addressId,
    );

    getChossenAddress();
    update(['ChossenAddressId']);
  }

  @override
  chaingId(String id) {
    addressId = id;
    update(['addressId']);
  }

  @override
  Future<void> updateAddress(Address address) async {
    updateAddressesstatusrequest = Statusrequest.loading;
    update(['updateAddresses']);
    log("address json: ${address.toJson()}");
    final result = await getAddressessImp.updateAddress(address: address);

    result.fold(
      (failure) {
        updateAddressesstatusrequest = Statusrequest.failuer;
        showCustomGetSnack(isGreen: false, text: failure.errorMessage);
      },
      (successMessage) {
        updateAddressesstatusrequest = Statusrequest.success;
        fetchAddresses();

        Get.back();
        showCustomGetSnack(isGreen: true, text: successMessage);
      },
    );
    update(['updateAddresses']);
  }
}
