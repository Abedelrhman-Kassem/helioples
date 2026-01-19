// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sign_up_repo.dart';
// import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sign_up_states.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   final SignUpRepo signUpRepo;
//   SignUpCubit(this.signUpRepo) : super(SignUpInitial());
//   String? verificationId;

//   // Future<void> singUp(RegisterModel registerModel) async {
//   //   emit(SignUpLoading());
//   //   final Either<Failure, Map<String, dynamic>> response =
//   //       await signUpRepo.signUp(registerModel);
//   //   response.fold((failure) => emit(SignUpFailure(failure.errorMessage)),
//   //       (status) {
//   //     verificationId = status['verificationId'];
//   //     emit(SignUpSuccess(status));
//   //   });
//   // }
// }
