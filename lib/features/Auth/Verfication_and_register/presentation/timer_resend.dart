import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/cubit/verfy_and_register_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TimerResend extends StatefulWidget {
  const TimerResend({super.key});

  @override
  State<TimerResend> createState() => _TimerResendState();
}

class _TimerResendState extends State<TimerResend> {
  static const int initialSeconds = 3600; // الوقت الكامل بعد الإرسال
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _canResend =
      true; // سنحدد قيمته في initState بناءً على وجود verificationId
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // نفحص الـ cubit: إذا فيه verificationId معناته الكود اتبعت من قبل -> نبدأ العداد
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<VerfyAndRegisterCubit>();
      if (cubit.otpModel.verificationId.isNotEmpty) {
        // لو فيه قيمة نعتبر أن الكود سبق إرساله ونعطل زر resend ونبدأ العد
        setState(() {
          _canResend = false;
        });
        startCountdown(seconds: initialSeconds);
      } else {
        // مفيش قيمة => اسمح بالارسال فورًا
        setState(() {
          _canResend = true;
          _remainingSeconds = 0;
        });
      }
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

    setState(() {
      _isLoading = true;
      _canResend = false; // تأمين إضافي
    });

    final cubit = context.read<VerfyAndRegisterCubit>();
    final phone = cubit.otpModel.registerModel.phone;
    try {
      final res = await SendOtpHelper.verifyPhone('+2$phone');
      res.fold(
        (err) {
          // فشل في إرسال الكود
          showCustomGetSnack(
            duration: const Duration(seconds: 4),
            isGreen: false,
            text: "Failed to resend OTP: $err",
          );
          setState(() {
            _isLoading = false;
            _canResend = true; // اعط المستخدم فرصة لإعادة المحاولة فورًا
          });
        },
        (data) {
          // نجاح الإرسال
          showCustomGetSnack(
            isGreen: true,
            text: LocaleKeys.login_screen_verification_sent.tr(),
          );

          // خزّن القيم في cubit بشكل صحيح
          // cubit.otpModel.verificationId = data.verificationId;
          // cubit.resendToken = data.resendToken?.toString();
          // cubit.tempToken = data.tempToken; // <-- صحّحت هنا

          // أعد تشغيل العدّ من البداية
          startCountdown(seconds: initialSeconds);
          cubit.changeClearText();

          setState(() {
            _isLoading = false;
          });
        },
      );
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
    // cubit.verificationId = "123456";
    // cubit.changeClearText();
    // startCountdown(seconds: initialSeconds);

    setState(() {
      _isLoading = false;
    });
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
            StringTranslateExtension(
                    LocaleKeys.verification_screen_didnt_receive_code)
                .tr(),
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
                    StringTranslateExtension(
                            LocaleKeys.verification_screen_resend_code)
                        .tr(),
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
