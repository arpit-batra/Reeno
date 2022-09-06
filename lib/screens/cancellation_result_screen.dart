import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/screens/my_bookings_screen.dart';
import 'package:reeno/screens/sport_centre_list_screen.dart';
import 'package:reeno/widgets/cards/booking_time_widget.dart';
import 'package:reeno/widgets/cards/centre_address_widget.dart';
import 'package:reeno/providers/selected_booking_provider.dart';
import 'package:reeno/widgets/cards/refund_card.dart';
import 'package:reeno/widgets/cards/support_card.dart';

class CancellationResultScreen extends StatelessWidget {
  const CancellationResultScreen({Key? key}) : super(key: key);
  static const routeName = '/cancellation-result-screen';

  Widget _getActionButton(String msg, int pos, Function onClick) {
    return Expanded(
      child: Container(
        padding: pos == 0
            ? const EdgeInsets.only(left: 16, right: 8, bottom: 16)
            : const EdgeInsets.only(left: 8, right: 16, bottom: 16),
        height: 64,
        child: ElevatedButton(
          onPressed: (() {
            onClick();
          }),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              msg,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  void _goToHome(BuildContext context) {
    //TODO null all selected centres and dates
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _goToMyBookings(BuildContext context) {
    _goToHome(context);
    Navigator.of(context).pushNamed(MyBookingsScreen.routeName);
  }

  // void _tryAgain(BuildContext context) {
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    final _isCancellationSuccessful =
        ModalRoute.of(context)!.settings.arguments as bool;
    print(_isCancellationSuccessful);
    final primaryTitleMsg = _isCancellationSuccessful
        ? "Cancellation Confirmed"
        : "Cancellation Failed";
    final secondaryTitleMsg = _isCancellationSuccessful
        ? "Your slot has been successfully cancelled"
        : "We were unable to cancel your slot";
    final mainIcon =
        _isCancellationSuccessful ? Icons.check_circle : Icons.error;
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 5,
              child: Container(
                color: _isCancellationSuccessful
                    ? const Color.fromRGBO(29, 185, 84, 1)
                    : const Color.fromRGBO(191, 60, 18, 1),
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: Icon(
                          mainIcon,
                          color: Colors.white,
                          size: 128,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            primaryTitleMsg,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              secondaryTitleMsg,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  if (_isCancellationSuccessful)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RefundCard(),
                    ),
                  if (!_isCancellationSuccessful)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: SupportCard(),
                    ),
                ],
              )),
            ),
            Row(
              children: [
                _isCancellationSuccessful
                    ? _getActionButton("My Bookings", 0, () {
                        _goToMyBookings(context);
                      })
                    : _getActionButton("Try Again", 0, () {
                        _goToMyBookings(context);
                      }),
                _getActionButton("Home", 1, () {
                  _goToHome(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
