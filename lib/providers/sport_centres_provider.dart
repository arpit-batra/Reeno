import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/models/sport_centre_meta.dart';

class SportCentresProvider with ChangeNotifier {
  List<SportCentreMeta> _sportCentreMetas = [];
  String _selectedCentreId = "";
  SportCentre? _selectedSportCentre;

  List<SportCentreMeta> get sportCentreMetas {
    return [..._sportCentreMetas];
  }

  SportCentreMeta get selectedCentreMeta {
    return _sportCentreMetas
        .firstWhere((element) => element.detailsId == _selectedCentreId);
  }

  SportCentreMeta getCentreMetaByDetailId(String id) {
    return _sportCentreMetas.firstWhere((element) => element.detailsId == id);
  }

  String get selectedCentreId {
    return _selectedCentreId;
  }

  // SportCentre get selectedSportCentre {
  //   return _sportCentres
  //       .firstWhere((element) => element.id == _selectedCentreId);
  // }

  SportCentre get selectedSportCentre {
    ////////////////////////////////////////////////
    if (_selectedSportCentre == null) {
      return SportCentre(
        id: "",
        title: "",
        address: Address(displayAddress: "", coordinates: LatLng(0, 0)),
        sport: Sport.none,
        images: [],
        description: "",
        hourlyRate: 0,
        leastInterval: Duration(),
        minimumTime: Duration(),
        openingTime: TimeOfDay(hour: 0, minute: 0),
        closingTime: TimeOfDay(hour: 0, minute: 0),
      );
      ////////////////////////////////////////////////
    }
    return _selectedSportCentre!;
  }

  void setSelectCentre(String id) {
    _selectedCentreId = id;
    notifyListeners();
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

  Future<void> fetchSelectedSportCentre() async {
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres')
        .withConverter(
            fromFirestore: SportCentre.fromFirestore,
            toFirestore: (SportCentre sportCentre, _) =>
                sportCentre.toFirestore());
    final centre = await docRef.doc(_selectedCentreId).get();
    if (centre.data() != null) {
      _selectedSportCentre = centre.data();
      notifyListeners();
    }
  }

  Future<void> fetchSportCentresMetas() async {
    print("Fetching Sport Centre Metas");
    final docRef = FirebaseFirestore.instance
        .collection('sport_centres_meta')
        .withConverter(
            fromFirestore: SportCentreMeta.fromFirestore,
            toFirestore: (SportCentreMeta sportCentre, _) =>
                sportCentre.toFirestore());
    final centres = await docRef.get();
    // final List<SportCentreMeta> metaList = [];
    // for (final element in centres.docs) {
    //   metaList.add(element.data());
    // }
    // _sportCentreMetas = metaList;
    _sportCentreMetas = [];
    for (final element in centres.docs) {
      _sportCentreMetas.add(element.data());
    }
    notifyListeners();
  }
}
