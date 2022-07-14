import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/screens/login/get_user_info_screen.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/sport_centre_list_widgets/sport_centre_list_tile.dart';
import 'package:reeno/models/user.dart' as CustomUser;
import 'package:reeno/providers/user_provider.dart';

class SportCentreListScreen extends StatefulWidget {
  const SportCentreListScreen({Key? key}) : super(key: key);

  @override
  State<SportCentreListScreen> createState() => _SportCentreListScreenState();
}

class _SportCentreListScreenState extends State<SportCentreListScreen> {
  bool _isFirstRun = true;
  String _userDisplayName = "";

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isFirstRun) {
      _isFirstRun = false;
      final currUser = FirebaseAuth.instance.currentUser;
      final enteredPhoneNumber = currUser?.phoneNumber;
      final enteredEmail = currUser?.email;
      if (enteredPhoneNumber != null) {
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
        });
      }
      if (enteredEmail != null) {
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

      // print("PROVV0");
      await Provider.of<SportCentresProvider>(context, listen: false)
          .fetchSportCentresMetas();

      // final user = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(FirebaseAuth.instance.currentUser?.uid)
      //     .withConverter(
      //         fromFirestore: CustomUser.User.fromFirestore,
      //         toFirestore: (CustomUser.User user, options) =>
      //             user.toFirestore())
      //     .get();
      // _userDisplayName = user.data()?.name ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final metas = Provider.of<SportCentresProvider>(context).sportCentreMetas;
    print("meta lenght -> ${metas.length}");
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserProvider>(
            builder: ((context, value, child) =>
                Text('Welcome ${value.user?.name ?? ''}'))),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return SportCentreListTile(
                title: metas[index].title, imageUrl: metas[index].imageUrl);
          },
          itemCount: metas.length,
        ),
      ),
    );
  }
}
