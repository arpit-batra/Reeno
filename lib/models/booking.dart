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
  final int cancelPolicyDuration;
  double cancellationCharge;
  bool cancelled;

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
    required this.cancelPolicyDuration,
    required this.cancellationCharge,
    required this.cancelled,
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
        orderId: data?['orderId'],
        paymentId: data?['paymentId'],
        signature: data?['signature'],
        courtNo: data?['courtNo'],
        startTime: DateTime.parse(data?['startTime']),
        endTime: DateTime.parse(data?['endTime']),
        amount: (data?['amount'] as num) as double,
        cancelPolicyDuration: data?['cancelPolicyDuration'],
        cancellationCharge: (data?['cancellationCharge'] as num) as double,
        cancelled: data?['cancelled']);
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
      "cancelPolicyDuration": cancelPolicyDuration,
      "cancellationCharge": cancellationCharge,
      "cancelled": cancelled,
    };
  }

  Map toJson() {
    return {
      "id": id,
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
      "cancelPolicyDuration": cancelPolicyDuration,
      "cancellationCharge": cancellationCharge,
      "cancelled": cancelled,
    };
  }
}
