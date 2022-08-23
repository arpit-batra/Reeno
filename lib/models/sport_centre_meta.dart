import 'package:cloud_firestore/cloud_firestore.dart';

class SportCentreMeta {
  final String id;
  final String title;
  final String imageUrl;
  final String detailsId;

  SportCentreMeta({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.detailsId,
  });

  factory SportCentreMeta.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return SportCentreMeta(
        id: snapshot.id,
        title: data?['title'],
        imageUrl: data?['imageUrl'],
        detailsId: data?['detailsId']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "imageUrl": imageUrl,
      "detailsId": detailsId,
    };
  }
}
