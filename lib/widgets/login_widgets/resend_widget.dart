import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reeno/helpers/phone_authentication.dart';

//Should be less than or equal to 60
const timeLimit = 60;

class ResendWidget extends StatefulWidget {
  final phoneNumber;
  const ResendWidget(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _ResendWidgetState createState() => _ResendWidgetState();
}

class _ResendWidgetState extends State<ResendWidget> {
  var _ticker = 0;
  var showResend = false;
  var _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _ticker = timer.tick;
        if (timeLimit - _ticker == 0) showResend = true;
        if (_ticker == timeLimit) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: showResend
            ? () {
                Navigator.of(context).pop();
                PhoneAuthentication.verifyPhone(widget.phoneNumber, context);
              }
            : null,
        child: showResend
            ? const Text('Resend')
            : Text(
                '0:${timeLimit - _ticker}',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.start,
              ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
