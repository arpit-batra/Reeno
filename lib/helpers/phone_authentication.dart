import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reeno/providers/phone_provider.dart';
import 'package:reeno/screens/login/phone_login_screen.dart';
import 'package:provider/provider.dart';

import '../screens/login/otp_screen.dart';

class PhoneAuthentication {
  static final auth = FirebaseAuth.instance;

  static Future<void> _showErrorDialog(context, FirebaseAuthException err) {
    return showDialog(
        context: context,
        builder: (context) {
          return (AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushReplacementNamed(PhoneLoginScreen.routeName);
                },
                child: const Text('Retry'),
              ),
            ],
            content: Text(err.code),
            contentPadding: const EdgeInsets.all(32),
          ));
        });
  }

  static Future<void> verifyPhone(phoneNumber, context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('VeroCompleted');
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException err) {
        _showErrorDialog(context, err);
      },
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) async {
        print('VeroCodeSent');
        final String codeEntered = (await Navigator.of(context)
                .pushNamed(OtpScreen.routeName, arguments: phoneNumber))
            .toString();

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: codeEntered);

        try {
          await auth.signInWithCredential(credential);
          Provider.of<PhoneProvider>(context, listen: false)
              .setPhoneNumber(phoneNumber);
        } on FirebaseAuthException catch (err) {
          _showErrorDialog(context, err);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('VeroCodeAutoRetrieval');
      },
    );
  }
}
