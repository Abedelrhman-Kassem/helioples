import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
// SendOtpHelper.
  String? verificationId;
  bool codeSent = false;
  bool loading = false;

  Future<void> verifyPhone(String phoneNumber) async {
    setState(() => loading = true);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم التحقق تلقائيًا! ✅')),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل التحقق: ${e.message}')),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          codeSent = true;
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إرسال الكود ✅')),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> signInWithSmsCode() async {
    if (verificationId == null) return;
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: codeController.text.trim(),
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase OTP Test')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!codeSent) ...[
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'رقم الهاتف (مثال: +201234567890)',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          verifyPhone(phoneController.text.trim());
                        },
                        child: const Text('إرسال الكود'),
                      ),
                    ] else ...[
                      TextField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'أدخل الكود المرسل',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: signInWithSmsCode,
                        child: const Text('تأكيد الكود'),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
