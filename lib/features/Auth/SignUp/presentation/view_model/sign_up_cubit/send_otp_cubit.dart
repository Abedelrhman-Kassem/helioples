import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/send_otp_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';

class SendOtpCubit extends Cubit<SentOtpState> {
  final SendOtpRepo sendOtpRepo;
  SendOtpCubit(this.sendOtpRepo) : super(SentOtpInitial());

  Future<void> sendOtp(RegisterModel registerModel) async {
    emit(SentOtpLoading());
    final Either<Failure, OtpModel> response =
        await sendOtpRepo.sendOtp(registerModel);
    response.fold((failure) => emit(SentOtpFailure(failure.errorMessage)),
        (otpModel) {
      emit(SentOtpSuccess(otpModel));
    });
  }
}
