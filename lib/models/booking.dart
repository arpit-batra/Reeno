import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String? id;
  final String sportCentreId;
  final String sportCentreTitle;
  final String sportCentreAddress;
  final String userId;
  final String userName;
  final String date;
  final int courtNo;
  DateTime startTime;
  DateTime endTime;
  double amount;

  Booking({
    this.id,
    required this.sportCentreId,
    required this.sportCentreTitle,
    required this.sportCentreAddress,
    required this.userId,
    required this.userName,
    required this.date,
    required this.courtNo,
    required this.startTime,
    required this.endTime,
    required this.amount,
  });

  factory Booking.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Booking(
        id: snapshot.id,
        sportCentreId: data?['sportCentreId'],
        sportCentreTitle: data?['sportCentreTitle'],
        sportCentreAddress: data?['sportCentreAddress'],
        userId: data?['userId'],
        userName: data?['userName'],
        date: data?['date'],
        courtNo: int.parse(data?['courtNo']),
        startTime: DateTime.parse(data?['startTime']),
        endTime: DateTime.parse(data?['endTime']),
        amount: double.parse(data?['amount']));
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportCentreId": sportCentreId,
      "sportCentreTitle": sportCentreTitle,
      "sportCentreAddress": sportCentreAddress,
      "userId": userId,
      "userName": userName,
      "date": date,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "amount": amount,
    };
  }
}
