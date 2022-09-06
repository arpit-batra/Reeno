import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:reeno/app_config.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/screens/cancellation_result_screen.dart';

class CancellationDialog extends StatefulWidget {
  final Booking booking;
  const CancellationDialog(this.booking, {Key? key}) : super(key: key);

  @override
  State<CancellationDialog> createState() => _CancellationDialogState();
}

class _CancellationDialogState extends State<CancellationDialog> {
  var _loadingState = false;
  Future<bool> cloudFunctionCallToCancelBooking(String cloudFunctionUrl) async {
    final _isOwner =
        Provider.of<UserProvider>(context, listen: false).user!.owner!;
    final url = Uri.parse(cloudFunctionUrl);
    var api_response;
    if (_isOwner) {
      api_response = await http.post(url,
          headers: <String, String>{
            'content-type': 'application/json',
            'user': 'owner'
          },
          body: json.encode(widget.booking));
    } else {
      api_response = await http.post(url,
          headers: <String, String>{
            'content-type': 'application/json',
            'user': 'common'
          },
          body: json.encode(widget.booking));
    }

    print(api_response.statusCode);
    if (api_response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context)!;
    return SimpleDialog(
      title: Text(
        "Do you want to cancel this booking?",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
              '${widget.booking.cancellationCharge}% will be charged as cancellation price'),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: Text(
                      'NO',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _loadingState = true;
                      });
                      final result = await cloudFunctionCallToCancelBooking(
                          config.cancelBookingCloudFunctionUrl);
                      setState(() {
                        _loadingState = false;
                      });
                      if (result == true) {
                        Navigator.of(context).pushNamed(
                            CancellationResultScreen.routeName,
                            arguments: true);
                      } else {
                        Navigator.of(context).pushNamed(
                            CancellationResultScreen.routeName,
                            arguments: false);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).errorColor)),
                    child: _loadingState
                        ? CircularProgressIndicator()
                        : Text(
                            'YES',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
