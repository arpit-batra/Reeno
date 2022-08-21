import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../models/user.dart' as User;
import '../providers/user_provider.dart';

class GoogleAuthentication {
  static Future<void> _addUser(GoogleSignInAccount? googleUser) async {
    final currentUser = User.User(
      email: googleUser?.email,
      name: googleUser?.displayName,
      imageUrl: googleUser?.photoUrl,
    );
    final docRef = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: User.User.fromFirestore,
        toFirestore: (User.User user, options) => user.toFirestore());
    await docRef.doc(googleUser?.id).set(currentUser);
  }

  static void signInWithGoogle(context) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      print(googleUser?.displayName);
      print(googleUser?.photoUrl);

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .where("email", isEqualTo: googleUser?.email)
      //     .limit(1)
      //     .get()
      //     .then((value) {
      //   if (value.size == 0) {
      //     Provider.of<UserProvider>(context, listen: false).addUser(
      //         googleUser?.id,
      //         googleUser?.email,
      //         null,
      //         googleUser?.photoUrl,
      //         googleUser?.displayName);
      //   } else {
      //     return;
      //   }
      // });
    } on FirebaseAuthException catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to login, try again!'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Unable to login, try again!'),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }
}
