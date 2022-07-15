import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/models/sport_centre_meta.dart';

class SportCentresProvider with ChangeNotifier {
  List<SportCentre> _sportCentres = [];
  List<SportCentreMeta> _sportCentreMetas = [];
  String _selectedCentreId = "";

  List<SportCentre> get sportCentres {
    return [..._sportCentres];
  }

  List<SportCentreMeta> get sportCentreMetas {
    return [..._sportCentreMetas];
  }

  Future<SportCentre?> getsportCentreById(String id) async {
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres')
        .withConverter(
            fromFirestore: SportCentre.fromFirestore,
            toFirestore: (SportCentre sportCentre, _) =>
                sportCentre.toFirestore());
    final centre = await docRef.doc(id).get();
    if (centre.data() == null) {
      return null;
    } else {
      return centre.data();
    }
  }

  void setSelectCentre(String id) {
    _selectedCentreId = id;
  }

  SportCentre get selectedSportCentre {
    return _sportCentres
        .firstWhere((element) => element.id == _selectedCentreId);
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

  Future<void> fetchSportCentresMetas() async {
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres_meta')
        .withConverter(
            fromFirestore: SportCentreMeta.fromFirestore,
            toFirestore: (SportCentreMeta sportCentre, _) =>
                sportCentre.toFirestore());
    final centres = await docRef.get();
    final List<SportCentreMeta> metaList = [];
    for (final element in centres.docs) {
      metaList.add(element.data());
    }
    _sportCentreMetas = metaList;
    notifyListeners();
  }
}
