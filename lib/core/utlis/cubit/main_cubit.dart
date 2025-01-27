import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/address_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo_imp.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  List<Map<String, Object?>>? tableValues;
  Future<void> clearDb() async {
    tableValues = await DBHelper.queryData(table: cartTable);

    await DBHelper.deleteData(table: cartTable);
  }

  GetAddressessImp getAddressessImp = GetAddressessImp(ApiService());

  AddressModel mainaddressModel = AddressModel(address: []);

  Future<void> getAddressess() async {
    emit(LoadingAddresses());

    Either<Failure, AddressModel> res = await getAddressessImp.getAddressess();

    res.fold(
      (failure) {
        emit(
          GetAddressesFailed(failure.errorMessage),
        );
      },
      (addressModel) async {
        mainaddressModel = addressModel;
        await getChossenAddress();
        emit(
          GetAddressesSuccessfully(addressModel),
        );
      },
    );
  }

  Address? address;

  Future<void> getChossenAddress() async {
    int? addressId = await getChossenAddressId();

    address = mainaddressModel.address!.firstWhere(
      (element) => element.id == addressId,
      orElse: () => mainaddressModel.address!.first,
    );
  }

  Future<int?> getChossenAddressId() async {
    return await CacheHelper.getSharedPreferenceData(key: 'addressId');
  }

  Future<void> setChossenAddress(int addressId) async {
    await CacheHelper.saveSharedPreferencesData(
      key: 'addressId',
      value: addressId,
    );

    getChossenAddress();
  }
}
