import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String sportCentreId;
  final String userId;
  final String date;
  final DateTime startTime;
  final DateTime endTime;

  Booking({
    required this.id,
    required this.sportCentreId,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  factory Booking.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Booking(
        id: snapshot.id,
        sportCentreId: data?['sportCentreId'],
        userId: data?['userId'],
        date: data?['date'],
        startTime: DateTime.parse(data?['startTime']),
        endTime: DateTime.parse(data?['endTime']));
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportCentreId": sportCentreId,
      "userId": userId,
      "date": date,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
    };
  }
}
