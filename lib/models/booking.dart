import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String? id;
  final String sportCentreId;
  final String sportCentreTitle;
  final String sportCentreAddress;
  final String userId;
  final String userName;
  final String date;
  String orderId;
  String paymentId;
  String signature;
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
    required this.orderId,
    required this.paymentId,
    required this.signature,
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
    print("data => $data");
    return Booking(
        id: snapshot.id,
        sportCentreId: data?['sportCentreId'],
        sportCentreTitle: data?['sportCentreTitle'],
        sportCentreAddress: data?['sportCentreAddress'],
        userId: data?['userId'],
        userName: data?['userName'],
        date: data?['date'],
        orderId: data?['orderId'],
        paymentId: data?['paymentId'],
        signature: data?['signature'],
        courtNo: data?['courtNo'],
        startTime: DateTime.parse(data?['startTime']),
        endTime: DateTime.parse(data?['endTime']),
        amount: (data?['amount'] as num) as double);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sportCentreId": sportCentreId,
      "sportCentreTitle": sportCentreTitle,
      "sportCentreAddress": sportCentreAddress,
      "userId": userId,
      "userName": userName,
      "date": date,
      "orderId": orderId,
      "paymentId": paymentId,
      "signature": signature,
      "courtNo": courtNo,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "amount": amount,
    };
  }

  Map toJson() {
    return {
      "sportCentreId": sportCentreId,
      "sportCentreTitle": sportCentreTitle,
      "sportCentreAddress": sportCentreAddress,
      "userId": userId,
      "userName": userName,
      "date": date,
      "orderId": orderId,
      "paymentId": paymentId,
      "signature": signature,
      "courtNo": courtNo,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "amount": amount,
    };
  }
}
