import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reeno/screens/phone_login_screen.dart';

import './../screens/otp_screen.dart';

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
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(e.message!),
        //   backgroundColor: Theme.of(context).errorColor,
        // ));
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
