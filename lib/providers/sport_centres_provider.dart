import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/models/sport_centre_meta.dart';

class SportCentresProvider with ChangeNotifier {
  List<SportCentreMeta> _sportCentreMetas = [];
  String _selectedCentreId = "";
  SportCentre? _selectedSportCentre;
  int _selectedCourtNo = 0;

  List<SportCentreMeta> get sportCentreMetas {
    return [..._sportCentreMetas];
  }

  SportCentreMeta get selectedCentreMeta {
    return _sportCentreMetas
        .firstWhere((element) => element.detailsId == _selectedCentreId);
  }

  int get selectedCourtNo {
    return _selectedCourtNo;
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
      print("HE HE HE");
      return SportCentre(
          id: "sadfdsfsdf",
          title: "sdfsdf",
          address:
              Address(displayAddress: "sdgsfhnfga", coordinates: LatLng(0, 0)),
          sport: Sport.badminton,
          images: [
            "https://media.istockphoto.com/photos/line-on-green-badminton-court-picture-id1040174714?k=20&m=1040174714&s=612x612&w=0&h=euM1AD1Qtqbwfkp2hpI12X9-HEwj7wylp1HXXVQkQKA=",
            "https://t3.ftcdn.net/jpg/02/23/27/28/360_F_223272802_WitEnJSzsXNKaqESPFSdfmuR0KeDjbV6.jpg"
          ],
          description: "This is a sample",
          hourlyRate: 200,
          leastInterval: Duration(seconds: 1),
          minimumTime: Duration(seconds: 1),
          openingTime: TimeOfDay(hour: 0, minute: 0),
          closingTime: TimeOfDay(hour: 0, minute: 0),
          numberOfCourts: 2,
          amenities: ["sdff", "sdfsdf", "ehdfgh"],
          cancelPolicyDuration: 60,
          cancellationCharge: 10,
          cancellationPolicy: "Some Cancellation Policy");
    }
    ////////////////////////////////////////////////
    return SportCentre(
      id: _selectedSportCentre!.id,
      title: _selectedSportCentre!.title,
      address: _selectedSportCentre!.address,
      sport: _selectedSportCentre!.sport,
      images: _selectedSportCentre!.images,
      description: _selectedSportCentre!.description,
      hourlyRate: _selectedSportCentre!.hourlyRate,
      leastInterval: _selectedSportCentre!.leastInterval,
      minimumTime: _selectedSportCentre!.minimumTime,
      openingTime: _selectedSportCentre!.openingTime,
      closingTime: _selectedSportCentre!.closingTime,
      numberOfCourts: _selectedSportCentre!.numberOfCourts,
      amenities: _selectedSportCentre!.amenities,
      cancelPolicyDuration: _selectedSportCentre!.cancelPolicyDuration,
      cancellationCharge: _selectedSportCentre!.cancellationCharge,
      cancellationPolicy: _selectedSportCentre!.cancellationPolicy,
    );
  }

  void setSelectCentre(String id) {
    _selectedCentreId = id;
    notifyListeners();
  }

  void setSelectedCourtNo(int courtNo) {
    _selectedCourtNo = courtNo;
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
