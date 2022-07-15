import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/user.dart' as CustomUser;

class UserProvider with ChangeNotifier {
  CustomUser.User? _user;

  CustomUser.User? get user {
    return CustomUser.User(
        id: _user?.id,
        email: _user?.email,
        phone: _user?.phone,
        imageUrl: _user?.imageUrl,
        name: _user?.name);
  }

  Future<void> fetchUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: CustomUser.User.fromFirestore,
        toFirestore: (CustomUser.User user, options) => user.toFirestore());
    final userSnapshot = await docRef.doc(uid).get();
    _user = userSnapshot.data();
    notifyListeners();
  }

  Future<void> addUser(String? id, String? email, String? phone,
      String? imageUrl, String? name) async {
    final currentUser = CustomUser.User(
      phone: phone,
      email: email,
      name: name,
      imageUrl: imageUrl,
    );
    final docRef = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: CustomUser.User.fromFirestore,
        toFirestore: (CustomUser.User user, options) => user.toFirestore());
    await docRef.doc(id).set(currentUser);
    _user = currentUser;
    notifyListeners();
  }
}