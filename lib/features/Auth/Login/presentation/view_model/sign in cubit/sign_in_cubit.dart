import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo_imp.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_states.dart';

class SignInCubit extends Cubit<SignInStates> {
  final LogInRepoImp signInRepo;
  SignInCubit(this.signInRepo) : super(const SignInStates.initial());
  // LoginModel? loginModel;

  // static SignInCubit get(context) => BlocProvider.of(context);

  Future<void> signIn(String phone) async {
    emit(const SignInStates.loading());
    Either<Failure, LoginModel> result = await signInRepo.signIn(phone);
    result.fold((failure) => emit(SignInStates.failure(failure.errorMessage)),
        (status) {
      // loginModel = status;

      emit(SignInStates.success(status));
    });
  }
}
