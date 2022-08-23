import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Sport { badminton, futsal, cricket, none }

class Address {
  final String displayAddress;
  final LatLng coordinates;

  Address({required this.displayAddress, required this.coordinates});

  factory Address.fromFirestore(Map data) {
    return Address(
        displayAddress: data['displayAddress'],
        coordinates: LatLng(
            data['coordinates'].latitude, data['coordinates'].longitude));
  }
}

class Review {
  final int stars;
  final String? comment;

  Review({required this.stars, this.comment});

  factory Review.fromFirestore(Map data) {
    return Review(stars: data['stars'], comment: data['comment']);
  }
}

class SportCentre {
  final String id;
  final String title;
  final Address address;
  final Sport sport;
  final List<String>? images;
  final String description;
  final double? rating;
  final List<Review>? reviews;
  final double hourlyRate;
  final Duration minimumTime;
  final Duration leastInterval;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  final int numberOfCourts;
  final List<String>? amenities;

  SportCentre({
    required this.id,
    required this.title,
    required this.address,
    required this.sport,
    required this.images,
    required this.description,
    this.rating,
    this.reviews,
    required this.hourlyRate,
    required this.leastInterval,
    required this.minimumTime,
    required this.openingTime,
    required this.closingTime,
    required this.numberOfCourts,
    required this.amenities,
  });

  factory SportCentre.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final sportString = data?['sport'];
    Sport sport;
    if (sportString == 'badminton') {
      sport = Sport.badminton;
    } else if (sportString == 'cricket') {
      sport = Sport.cricket;
    } else if (sportString == 'futsal') {
      sport = Sport.futsal;
    } else {
      sport = Sport.none;
    }

    return SportCentre(
      id: snapshot.id,
      title: data?['title'],
      address: Address.fromFirestore(data?['address']),
      sport: sport,
      images: data?['images'] is Iterable ? List.from(data?['images']) : null,
      description: data?['description'],
      hourlyRate: data?['hourlyRate'].toDouble(),
      rating: data?['rating'],
      reviews: data?['reviews'] is Iterable
          ? List.from(data?['reviews'])
              .map((e) => Review.fromFirestore(e))
              .toList()
          : null, //
      leastInterval: Duration(minutes: data?['leastInterval']),
      minimumTime: Duration(minutes: data?['minimumTime']),
      openingTime: TimeOfDay(hour: data?['openingTime'], minute: 0),
      closingTime: TimeOfDay(hour: data?['closingTime'], minute: 0),
      numberOfCourts: data?['numberOfCourts'],
      amenities:
          data?['amenities'] is Iterable ? List.from(data?['amenities']) : null,
    );
  }

// Not used but was required for the converter attribute. Obvio, doesnt function as reqd
  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
    };
  }
}
