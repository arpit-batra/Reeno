import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './../screens/otp_screen.dart';

class PhoneAuthentication {
  static final auth = FirebaseAuth.instance;

  static Future<void> verifyPhone(phoneNumber, context) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('VeroCompleted');
          await auth.signInWithCredential(credential);
        },

//     Error Codes
// auth/account-exists-with-different-credential
// Thrown if there already exists an account with the email address asserted by the credential. Resolve this by calling firebase.auth.Auth.fetchSignInMethodsForEmail and then asking the user to sign in using one of the returned providers. Once the user is signed in, the original credential can be linked to the user with firebase.User.linkWithCredential.
// auth/invalid-credential
// Thrown if the credential is malformed or has expired.
// auth/operation-not-allowed
// Thrown if the type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.
// auth/user-disabled
// Thrown if the user corresponding to the given credential has been disabled.
// auth/user-not-found
// Thrown if signing in with a credential from firebase.auth.EmailAuthProvider.credential and there is no user corresponding to the given email.
// auth/wrong-password
// Thrown if signing in with a credential from firebase.auth.EmailAuthProvider.credential and the password is invalid for the given email, or if the account corresponding to the email does not have a password set.
// auth/invalid-verification-code
// Thrown if the credential is a firebase.auth.PhoneAuthProvider.credential and the verification code of the credential is not valid.
// auth/invalid-verification-id
// Thrown if the credential is a firebase.auth.PhoneAuthProvider.credential and the verification ID of the credential is not valid.
// Example

// firebase.auth().signInWithCredential(credential).catch(function(error) {
//   // Handle Errors here.
//   var errorCode = error.code;
//   var errorMessage = error.message;
//   // The email of the user's account used.
//   var email = error.email;
//   // The firebase.auth.AuthCredential type that was used.
//   var credential = error.credential;
//   if (errorCode === 'auth/account-exists-with-different-credential') {
//     alert('Email already associated with another account.');
//     // Handle account linking here, if using.
//   } else {
//     console.error(error);
//   }
//  });

        //TODO Handle all error codes and display either a dialog box or SnackBar to give info to the user

        verificationFailed: (FirebaseAuthException e) {
          print('VeroFailed');
          print(e.message);
          if (e.code == 'auth/account-exists-with-different-credential') {
            print('Account already exists');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('VeroCodeSent');
          final String codeEntered =
              (await Navigator.of(context).pushNamed(OtpScreen.routeName))
                  .toString();
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: codeEntered);
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('VeroCodeAutoRetrieval');
        });
  }
}
