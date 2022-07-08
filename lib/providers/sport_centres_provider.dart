import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/models/sport_centre_meta.dart';

class SportCentresProvider with ChangeNotifier {
  List<SportCentre> _sportCentres = [];

  List<SportCentre> get sportCentres {
    return [..._sportCentres];
  }

  Future<void> fetchSportCentres() async {
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres')
        .withConverter(
            fromFirestore: SportCentre.fromFirestore,
            toFirestore: (SportCentre sportCentre, _) =>
                sportCentre.toFirestore());
    final centres = await docRef.get();
    print("PROVV3 ${centres.docs.first.data().address.coordinates}");
  }

  Future<void> fetchSortCentresMetas() async {
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres_meta')
        .withConverter(
            fromFirestore: SportCentreMeta.fromFirestore,
            toFirestore: (SportCentreMeta sportCentre, _) =>
                sportCentre.toFirestore());
    final centres = await docRef.get();
    print("PROVV3 ${centres.docs.first.data().title}");
  }
}
