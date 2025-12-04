import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationData {
  final String verificationId;
  final int? resendToken;

  VerificationData({required this.verificationId, this.resendToken});
}

class SendOtpHelper {
  /// Returns Either<errorMessage, VerificationData>
  static Future<Either<String, VerificationData>> verifyPhone(
      String phoneNumber,
      {Duration timeout = const Duration(seconds: 60)}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Completer<Either<String, VerificationData>> completer = Completer();

    // Safety timer in case callbacks never fire
    Timer? safetyTimer;
    safetyTimer = Timer(timeout + const Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.complete(
            const Left('Timeout: no response from verification service.'));
      }
    });

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Optional: you can automatically sign in here or return success.
          // We'll return a special message saying automatic verification happened.
          log('verificationCompleted (auto): $phoneNumber');

          // If you want to sign in automatically:
          // await auth.signInWithCredential(credential);

          if (!completer.isCompleted) {
            completer.complete(
                const Left('Automatic verification completed on device.'));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          log('verificationFailed: ${e.code} ${e.message}');
          if (!completer.isCompleted) {
            completer.complete(Left(e.message ?? 'Phone verification failed.'));
          }
        },
        codeSent: (String verId, int? resendToken) {
          log('codeSent to $phoneNumber, verificationId: $verId, resendToken: $resendToken');
          if (!completer.isCompleted) {
            completer.complete(Right(VerificationData(
                verificationId: verId, resendToken: resendToken)));
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          log('codeAutoRetrievalTimeout: verificationId=$verId');
          // We may already have completed via codeSent, but if not, complete with verId as fallback:
          if (!completer.isCompleted) {
            completer.complete(Right(VerificationData(verificationId: verId)));
          }
        },
      );
    } catch (e, st) {
      log('verifyPhone exception: $e\n$st');
      if (!completer.isCompleted) {
        completer.complete(Left('Failed to start phone verification: $e'));
      }
    }

    final result = await completer.future;
    safetyTimer.cancel();
    return result;
  }

// Returns Either<errorMessage, UserCredential>
  static Future<Either<String, bool>> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode.trim(),
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // نجاح
      log('Signed in UID: ${userCredential.user?.uid}');
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      // أمثلة على e.code: 'invalid-verification-code', 'session-expired', ...
      log('FirebaseAuthException during signInWithSmsCode: ${e.code} - ${e.message}');
      final errMsg = e.message ?? 'Firebase auth error: ${e.code}';
      return Left(errMsg);
    } catch (e, st) {
      log('Unknown error during signInWithSmsCode: $e\n$st');
      return const Left('Unknown error occurred while signing in.');
    }
  }
}
