import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/screens/schedule_screen.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
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
  @override
  Widget build(BuildContext context) {
    final centreId = ModalRoute.of(context)!.settings.arguments as String;
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
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    child: ScrollSnapList(
                        itemBuilder: (context, index) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                centre.images![index],
                                fit: BoxFit.cover,
                              ));
                        },
                        itemCount: centre.images?.length ?? 0,
                        itemSize: MediaQuery.of(context).size.width,
                        onItemFocus: (index) {}),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (() {
                          Navigator.of(context)
                              .pushNamed(ScheduleScreen.routeName);
                        }),
                        child: const Text(
                          'Book a slot',
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ],
              ));
        } else {
          return const LoadingScreen();
        }
      }),
    );
  }
}
