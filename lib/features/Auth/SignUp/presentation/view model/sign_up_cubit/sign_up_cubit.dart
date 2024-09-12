import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/user.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sign_up_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view%20model/sign_up_cubit/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpState> 
{
  final SignUpRepo signUpRepo ; 
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  Future<void> singUp(User user ) async 
  {
    emit(SignUpLoading()) ; 
    final Either<Failure,String> response = await signUpRepo.signUp(user);
    response.fold(
      (failure)=> emit(SignUpFailure(failure.errorMessage)),
      (status) => emit(SignUpSuccess(status))

       
      );
  }
  
}