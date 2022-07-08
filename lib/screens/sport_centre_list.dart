import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/screens/login/get_user_info_screen.dart';

class SportCentreList extends StatefulWidget {
  const SportCentreList({Key? key}) : super(key: key);

  @override
  State<SportCentreList> createState() => _SportCentreListState();
}

class _SportCentreListState extends State<SportCentreList> {
  bool _isFirstRun = true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isFirstRun) {
      final enteredPhoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
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
      print("PROVV0");
      await Provider.of<SportCentresProvider>(context, listen: false)
          .fetchSortCentresMetas();
      _isFirstRun = false;
    }
  }

  // @override
  // void didUpdateWidget(covariant SportCentreList oldWidget) async {
  //   super.didUpdateWidget(oldWidget);

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return const Text('hi');
            }));
  }
}
