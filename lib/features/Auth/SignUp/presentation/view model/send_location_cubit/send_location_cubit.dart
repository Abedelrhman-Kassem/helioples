import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Address/data/repo/set_address_rep_impl.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sign_up_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/send_location_cubit/send_location_states.dart';

class SendLocationCubit extends Cubit<SendLocationState> {
  // final SignUpRepo signUpRepo;
  final SetAddressRepImpl setAddressRepImpl;
  SendLocationCubit(this.setAddressRepImpl) : super(SendLocationInitial());

  // Future<void> sendLocation(double long, double lat) async {
  //   emit(SendLocationLoading());
  //   final Either<Failure, String> response =
  //       await signUpRepo.setLocation(long, lat);
  //   response.fold((failure) => emit(SendLocationFailure(failure.errorMessage)),
  //       (status) => emit(SendLocationSuccess(status)));
  // }

  Future<void> setAddress(double long, double lat, String locationStr,
      String buildingNo, String floor, String street, String department) async {
    emit(SendLocationLoading());
    final Either<Failure, String> response = await setAddressRepImpl.setAddress(
        long: long,
        lat: lat,
        locationStr: locationStr,
        buildingNo: buildingNo,
        floor: floor,
        street: street,
        department: department);
    response.fold(
      (failure) => emit(SendLocationFailure(failure.errorMessage)),
      (status) => emit(SendLocationSuccess(status)),
    );
  }
}
