import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Sport {
  badminton,
  futsal,
  cricket,
}

class Address {
  String? displayAddress;
  LatLng? coordinates;
}

class Review {
  late double stars;
  String? comment;
}

class Centre {
  late String id;
  late Address address;
  late Sport sport;
  late List<String> images;
  late String description;
  double? rating;
  List<Review>? reviews;
  late double hourlyRate;
  Duration? minimumTime;
  Duration? leastInterval;
}
