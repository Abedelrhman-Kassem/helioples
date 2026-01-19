import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/customer_model.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/update_profile_states.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepo profileRepo;

  UpdateProfileCubit({required this.profileRepo})
    : super(UpdateProfileInitial());

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String birthdate,
  }) async {
    emit(UpdateProfileLoading());

    final customer = CustomerModel(
      firstName: firstName,
      lastName: lastName,
      birthdate: birthdate,
    );

    final result = await profileRepo.updateProfile(customer);

    result.fold(
      (failure) => emit(UpdateProfileFailure(failure.errorMessage)),
      (response) => emit(UpdateProfileSuccess(response.data!)),
    );
  }

  Future<void> getProfile() async {
    emit(FetchProfileLoading());

    final result = await profileRepo.getProfile();

    result.fold(
      (failure) => emit(FetchProfileFailure(failure.errorMessage)),
      (response) => emit(FetchProfileSuccess(response.data!)),
    );
  }
}
