import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_states.dart';

class SignInCubit extends Cubit<SignInState> {
  final LogInRepo signInRepo;
  SignInCubit(this.signInRepo) : super(SignInInitial());
  String? verificationId;
  String? resendToken;
  String? tempToken;

  // static SignInCubit get(context) => BlocProvider.of(context);

  Future<void> signIn(String phone, String password) async {
    emit(SignInLoading());
    Either<Failure, Map<String, dynamic>> result =
        await signInRepo.signIn(phone, password);
    result.fold((failure) => emit(SignInFailure(failure.errorMessage)),
        (status) {
      tempToken = status['token'];
      verificationId = status['verificationId'];
      resendToken = status['resendToken'];
      emit(SignInSuccess(status));
    });
  }
}
