import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/screens/centre_info_screen.dart';
import 'package:reeno/screens/loading_screen.dart';
import 'package:reeno/screens/login/get_user_info_screen.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/sport_centre_list_widgets/sport_centre_list_tile.dart';
import 'package:reeno/providers/user_provider.dart';

class SportCentreListScreen extends StatefulWidget {
  const SportCentreListScreen({Key? key}) : super(key: key);
  static const routeName = 'sport-centre-list';

  @override
  State<SportCentreListScreen> createState() => _SportCentreListScreenState();
}

class _SportCentreListScreenState extends State<SportCentreListScreen> {
  bool _isFirstRun = true;
  late Future<void> sportMetaFuture;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isFirstRun) {
      _isFirstRun = false;
      final currUser = FirebaseAuth.instance.currentUser;
      final enteredPhoneNumber = currUser?.phoneNumber;
      final enteredEmail = currUser?.email;
      print("Phone Number $enteredPhoneNumber");
      print("Email $enteredEmail");
      if (enteredPhoneNumber != null && enteredPhoneNumber != "") {
        FirebaseFirestore.instance
            .collection('users')
            .where("phone", isEqualTo: enteredPhoneNumber)
            .limit(1)
            .get()
            .then((value) {
          if (value.size == 0) {
            Future((() =>
                Navigator.of(context).pushNamed(GetUserInfoScreen.routeName)));
          }
        }).catchError((error) {
          print(error);
          print(error.toString());
        });
      }
      if (enteredEmail != null && enteredEmail != "") {
        FirebaseFirestore.instance
            .collection('users')
            .where("email", isEqualTo: enteredEmail)
            .limit(1)
            .get()
            .then((value) {
          if (value.size == 0) {
            Provider.of<UserProvider>(context, listen: false).addUser(
                currUser?.uid,
                currUser?.email,
                null,
                currUser?.photoURL,
                currUser?.displayName);
          }
        });
      }

      await Provider.of<UserProvider>(context, listen: false).fetchUser();
    }
  }

  @override
  void initState() {
    super.initState();
    sportMetaFuture = Provider.of<SportCentresProvider>(context, listen: false)
        .fetchSportCentresMetas();
  }

  @override
  Widget build(BuildContext context) {
    // print("metas 0 ${metas.length}");
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserProvider>(
            builder: ((context, value, child) =>
                Text('Welcome ${value.user?.name ?? ''}'))),
        actions: [
          IconButton(
              onPressed: (() {
                FirebaseAuth.instance.signOut();
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: sportMetaFuture,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasError) {
              //TODO create a null screen
              return const Center(
                child: Text("Some error occurred"),
              );
            } else {
              final metas =
                  Provider.of<SportCentresProvider>(context).sportCentreMetas;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (() {
                      Provider.of<SportCentresProvider>(context, listen: false)
                          .setSelectCentre(metas[index].detailsId);
                      Navigator.of(context).pushNamed(
                          CentreInfoScreen.routeName,
                          arguments: metas[index].detailsId);
                    }),
                    child: SportCentreListTile(
                        title: metas[index].title,
                        imageUrl: metas[index].imageUrl),
                  );
                },
                itemCount: metas.length,
              );
            }
          }),
        ),
      ),
    );
  }
}
