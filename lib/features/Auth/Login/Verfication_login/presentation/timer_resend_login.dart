import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Auth/Login/Verfication_login/data/cubit/verfy_login_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';

class TimerResendLogin extends StatefulWidget {
  const TimerResendLogin({super.key});

  @override
  State<TimerResendLogin> createState() => _TimerResendLoginState();
}

class _TimerResendLoginState extends State<TimerResendLogin> {
  static const int initialSeconds = 3600; // 1 hour
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _canResend = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkTimer();
  }

  Future<void> _checkTimer() async {
    final lastResendStr = await ServicesHelper.getLocal('last_resend_time');
    if (lastResendStr != null) {
      final lastResendData = DateTime.tryParse(lastResendStr);
      if (lastResendData != null) {
        final diff = DateTime.now().difference(lastResendData).inSeconds;
        if (diff < initialSeconds) {
          startCountdown(seconds: initialSeconds - diff);
          return;
        }
      }
    }
    // No active timer found
    setState(() {
      _canResend = true;
      _remainingSeconds = 0;
    });
  }

  void startCountdown({int? seconds}) {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = seconds ?? initialSeconds;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          _canResend = true;
        });
      } else {
        setState(() {
          _remainingSeconds -= 1;
        });
      }
    });
  }

  String get _timeFormatted {
    if (_remainingSeconds <= 0) return '00 : 00';
    final minutes = (_remainingSeconds / 60).floor();
    final seconds = _remainingSeconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    return '$mm : $ss';
  }

  Future<void> _onTapResend() async {
    if (!_canResend || _isLoading) return;

    final cubit = context.read<VerfyLoginCubit>();
    final phone = cubit.loginModel?.phoneNumber ?? '';

    // Check if phone is valid
    if (phone.isEmpty) {
      showCustomGetSnack(
        duration: const Duration(seconds: 4),
        isGreen: false,
        text: "Phone number is missing",
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _canResend = false;
    });

    try {
      // Send OTP with timeout
      final res = await SendOtpHelper.verifyPhone('+2$phone').timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      res.fold(
        (err) {
          showCustomGetSnack(
            duration: const Duration(seconds: 4),
            isGreen: false,
            text: "Failed to resend OTP: $err",
          );
          setState(() {
            _isLoading = false;
            _canResend = true;
          });
        },
        (data) async {
          showCustomGetSnack(
            isGreen: true,
            text: LocaleKeys.login_screen_verification_sent.tr(),
          );

          if (cubit.loginModel != null) {
            cubit.loginModel!.verificationId = data.verificationId;
          }

          // Save timestamp
          await ServicesHelper.saveLocal(
            'last_resend_time',
            DateTime.now().toIso8601String(),
          );

          startCountdown(seconds: initialSeconds);
          cubit.changeClearText();

          setState(() {
            _isLoading = false;
          });
        },
      );
    } on TimeoutException {
      showCustomGetSnack(
        duration: const Duration(seconds: 4),
        isGreen: false,
        text: "Request timed out. Please try again.",
      );
      setState(() {
        _isLoading = false;
        _canResend = true;
      });
    } catch (e) {
      showCustomGetSnack(
        duration: const Duration(seconds: 4),
        isGreen: false,
        text: "Error while resending OTP",
      );
      setState(() {
        _isLoading = false;
        _canResend = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            _timeFormatted,
            style: Styles.styles12w500Black.copyWith(fontSize: 15),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Text(
            LocaleKeys.verification_screen_didnt_receive_code.tr(),
            style: Styles.styles15w400Black,
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: GestureDetector(
            onTap: _onTapResend,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    LocaleKeys.verification_screen_resend_code.tr(),
                    style: _canResend
                        ? Styles.styles15w700Gold
                        : Styles.styles15w700Gold.copyWith(color: Colors.grey),
                  ),
          ),
        ),
      ],
    );
  }
}
