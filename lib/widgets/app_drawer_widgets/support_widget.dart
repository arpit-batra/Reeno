import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SupportWidget {
  BuildContext context;
  SupportWidget(this.context);

  displaySupportInfo() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("support")
                      .doc("support")
                      .get(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Failed to Load");
                    } else {
                      final supportData = snapshot.data as DocumentSnapshot;
                      print(supportData['phone']);
                      print(supportData['email']);

                      // print(supportData);
                      // return Text(snapshot.data as String);

                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(supportData['phone']),
                          ),
                          ListTile(
                            leading: Icon(Icons.mail),
                            title: Text(supportData['email']),
                          ),
                        ],
                      );
                    }
                  }))

              // Row(children: [Icon(Icons.mail),Text()],)
              ;
        }));
  }
}
