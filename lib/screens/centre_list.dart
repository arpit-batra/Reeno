import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/screens/login/get_user_info_screen.dart';

class CentreList extends StatefulWidget {
  const CentreList({Key? key}) : super(key: key);

  @override
  State<CentreList> createState() => _CentreListState();
}

class _CentreListState extends State<CentreList> {
  //TODO use didChangeDependencies instead of initChange
  // @override
  // void initState() {
  //   super.initState();
  // }
  bool _isFirstRun = true;

  // @override
  // void didChangeDependencies() {}

  // @override
  // void didUpdateWidget(covariant CentreList oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
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
      _isFirstRun = false;
    }
    return const Scaffold(
      body: Center(
        child: Text('Hi there'),
      ),
    );
  }
}
