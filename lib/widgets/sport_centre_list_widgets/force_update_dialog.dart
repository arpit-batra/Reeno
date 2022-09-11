import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class ForceUpdateDialog extends StatelessWidget {
  const ForceUpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: SimpleDialog(
        title: Text(
          "Update Available",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text("Please update the app to continue"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
                onPressed: () {
                  LaunchReview.launch(androidAppId: "com.arpitbatra98.reeno");
                },
                child: Text("Update")),
          )
        ],
      ),
    );
  }
}
