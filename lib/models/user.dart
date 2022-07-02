import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? name;

  User({this.id, this.email, this.phone, this.imageUrl, this.name});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
        id: snapshot.id,
        email: data?['email'],
        phone: data?['phone'],
        imageUrl: data?['imageUrl'],
        name: data?['name']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      // if (id != null) "id": id,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (name != null) "name": name,
    };
  }
}
