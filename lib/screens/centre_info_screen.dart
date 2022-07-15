import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_loading/card_loading.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/models/sport_centre.dart';
import 'package:reeno/screens/loading_screen.dart';

class CentreInfoScreen extends StatefulWidget {
  const CentreInfoScreen({Key? key}) : super(key: key);

  static const routeName = "/centre-info-screen";

  @override
  State<CentreInfoScreen> createState() => _CentreInfoScreenState();
}

class _CentreInfoScreenState extends State<CentreInfoScreen> {
  bool _isFirstRun = true;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isFirstRun) {
  //     _isFirstRun = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final centreId = ModalRoute.of(context)!.settings.arguments as String;
    print("Centre ID -> $centreId");
    Provider.of<SportCentresProvider>(context, listen: false)
        .setSelectCentre(centreId);

    return FutureBuilder(
      future: Provider.of<SportCentresProvider>(context)
          .getsportCentreById(centreId),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          //TODO create error screen if data is not fetched from firebase
          return const Scaffold();
        } else if (snapshot.hasData) {
          final centre = snapshot.data as SportCentre;
          return Scaffold(
            appBar: AppBar(title: Text(centre.title)),
            body: Center(
              child: Text(centre.description),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      }),
    );

    // Scaffold(
    //   appBar: AppBar(
    //       title: FutureBuilder(
    //           future: _selectedCentre,
    //           builder: ((context, snapshot) {
    //             if (snapshot.hasData) {
    //               final centre = snapshot.data as SportCentre;
    //               return (Text(centre.title));
    //             } else if (snapshot.hasError) {
    //               return const Text("Something went wrong");
    //             } else {
    //               return (const CircularProgressIndicator());
    //             }
    //           }))),
    // );
  }
}
