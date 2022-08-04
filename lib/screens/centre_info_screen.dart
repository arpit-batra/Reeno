import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:reeno/screens/schedule_screen.dart';

import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/screens/loading_screen.dart';
import 'package:reeno/widgets/centre_info_screen_widgets/centre_images_widget.dart';

class CentreInfoScreen extends StatefulWidget {
  const CentreInfoScreen({Key? key}) : super(key: key);

  static const routeName = "/centre-info-screen";

  @override
  State<CentreInfoScreen> createState() => _CentreInfoScreenState();
}

class _CentreInfoScreenState extends State<CentreInfoScreen> {
  bool _isFirstRun = true;
  var centreId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstRun) {
      _isFirstRun = false;
      centreId = ModalRoute.of(context)!.settings.arguments as String;
      print("Centre ID -> $centreId");
    }
  }

  Widget _bookingButtons(SportCentre centre) {
    return Column(
      children: List<Widget>.generate(centre.numberOfCourts, (index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          width: double.infinity,
          child: ElevatedButton(
              onPressed: (() {
                Provider.of<SportCentresProvider>(context, listen: false)
                    .setSelectedCourtNo(index);
                Navigator.of(context).pushNamed(ScheduleScreen.routeName);
              }),
              child: Text(
                centre.numberOfCourts == 1
                    ? 'Book Court'
                    : 'Book Court ${index + 1}',
                style: const TextStyle(fontSize: 18),
              )),
        );
      }),
    );
  }

  Widget _bullet() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(24, 28, 123, 1),
        shape: BoxShape.circle,
      ),
    );
  }

  TextStyle _headingStyle() {
    return TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);
  }

  TextStyle _contentStyle() {
    return const TextStyle(fontSize: 16);
  }

  Widget _amenities(SportCentre centre) {
    final amenities = centre.amenities;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Amenities",
            style: _headingStyle(),
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 8 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  _bullet(),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    amenities![index],
                    style: _contentStyle(),
                  ),
                ],
              );
            },
            itemCount: amenities == null ? 0 : amenities.length,
          )
        ],
      ),
    );
  }

  Widget _description(SportCentre centre) {
    final description = centre.description;
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: _headingStyle(),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            description,
            style: _contentStyle(),
          ),
        ],
      ),
    );
  }

  Widget _address(SportCentre centre) {
    final address = centre.address;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address",
            style: _headingStyle(),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                address.displayAddress,
                style: _contentStyle(),
              ),
              IconButton(
                onPressed: () {
                  MapsLauncher.launchCoordinates(address.coordinates.latitude,
                      address.coordinates.longitude);
                },
                icon: const Icon(
                  Icons.directions,
                  color: Color.fromRGBO(24, 28, 123, 1),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SportCentresProvider>(context, listen: false)
          .fetchSelectedSportCentre(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          //TODO create error screen if data is not fetched from firebase
          return const Scaffold();
        } else {
          final centre =
              Provider.of<SportCentresProvider>(context).selectedSportCentre;
          return Scaffold(
            appBar: AppBar(title: Text(centre.title)),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CentreImagesWidget(centre),
                  _bookingButtons(centre),
                  _amenities(centre),
                  _description(centre),
                  _address(centre),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
