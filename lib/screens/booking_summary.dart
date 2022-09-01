import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:reeno/app_config.dart';
import 'package:reeno/providers/selected_booking_provider.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/screens/payment_results/after_payment_screen.dart';
import 'package:reeno/widgets/cards/booking_time_widget.dart';
import 'package:reeno/widgets/cards/centre_address_widget.dart';
import 'package:reeno/widgets/cards/payment_widget.dart';

class BookingSummary extends StatefulWidget {
  BookingSummary({Key? key}) : super(key: key);

  static const routeName = "/booking-summary";

  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  bool _loadingState = false;
  var _orderId = "";
  var _selectedBooking;
  // static const userName = "rzp_test_rUytAswPqSZROv";
  // static const secret = "hWBWWJ9Jd1zSHbxm6AVcf62d";
  var userName = "";
  var secret = "";
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    print("Booking Summary -> init");
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("success");
    print(_orderId);
    print(response.paymentId);
    print(response.signature);
    print(secret);

    Provider.of<SelectedBookingProvider>(context, listen: false).setPaymentInfo(
        orderId: _orderId,
        paymentId: response.paymentId,
        signature: response.signature);
    // final url = Uri.parse(
    //     'https://us-central1-reeno-5dce8.cloudfunctions.net/function-1');
    // final api_response = await http.post(url,
    //     headers: <String, String>{
    //       'content-type': 'application/json',
    //       'orderId': _orderId,
    //       'paymentId': response.paymentId!,
    //       'signature': response.signature!,
    //     },
    //     body: json.encode(_selectedBooking));

    // print(json.decode(api_response.body));
    final config = AppConfig.of(context)!;
    final api_result =
        await Provider.of<SelectedBookingProvider>(context, listen: false)
            .cloudFunctionCallToWriteBooking(config.cloudFunctionUrl);
    if (api_result) {
      Navigator.of(context)
          .pushNamed(AfterPaymentScreen.routeName, arguments: true);
    } else {
      Navigator.of(context)
          .pushNamed(AfterPaymentScreen.routeName, arguments: false)
          .then((value) {
        setState(() {
          _loadingState = false;
        });
      });
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("failure");
    Navigator.of(context)
        .pushNamed(AfterPaymentScreen.routeName, arguments: false)
        .then((value) {
      setState(() {
        _loadingState = false;
      });
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> _createOrder(double amount) async {
    try {
      final config = AppConfig.of(context)!;
      userName = config.rzpUserName;
      secret = config.rzpSecret;
      String basicAuth =
          'Basic ' + base64.encode(utf8.encode('$userName:$secret'));
      print(basicAuth);

      final url = Uri.parse('https://api.razorpay.com/v1/orders');
      final response = await http.post(url,
          headers: <String, String>{
            'authorization': basicAuth,
            'content-type': 'application/json'
          },
          body: json.encode(
              {"amount": amount * 100, "currency": "INR", "receipt": "rtp"}));

      print(json.decode(response.body)['id']);
      _orderId = json.decode(response.body)['id'];
      var options = {
        'key': userName,
        'amount': amount,
        'name': 'Reeno',
        'order_id': _orderId,
        'description': 'Slot Booking',
        'timeout': 120,
      };
      _razorpay.open(options);
      print("Booking Summary -> completed");
    } on Exception catch (err) {
      setState(() {
        _loadingState = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to Book, please check your connection"),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectedBooking =
        Provider.of<SelectedBookingProvider>(context).currBooking;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CentreAddressWidget(_selectedBooking),
                      const SizedBox(
                        height: 24,
                      ),
                      BookingTimeWidget(_selectedBooking),
                      const SizedBox(
                        height: 24,
                      ),
                      PaymentWidget(_selectedBooking),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _loadingState = true;
                        });
                        if (userProvider.user!.owner == null ||
                            userProvider.user!.owner == false ||
                            userProvider.user!.centreId !=
                                _selectedBooking.sportCentreId) {
                          _createOrder(_selectedBooking.amount);
                        } else {
                          try {
                            final config = AppConfig.of(context)!;
                            final apiResult =
                                await Provider.of<SelectedBookingProvider>(
                                        context,
                                        listen: false)
                                    .cloudFunctionCallToWriteBookingForOwner(
                                        config.cloudFunctionUrl);

                            if (apiResult) {
                              Navigator.of(context).pushNamed(
                                  AfterPaymentScreen.routeName,
                                  arguments: true);
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AfterPaymentScreen.routeName,
                                      arguments: false)
                                  .then((value) {
                                setState(() {
                                  _loadingState = false;
                                });
                              });
                            }
                          } on Exception catch (err) {
                            setState(() {
                              _loadingState = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Failed to Book, please check your connection"),
                              backgroundColor: Theme.of(context).errorColor,
                            ));
                          }
                        }
                      },
                      child: const Text(
                        "Proceed",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                )
              ],
            ),
          ),
          if (_loadingState)
            Container(
              color: const Color.fromARGB(100, 255, 255, 255),
            ),
          if (_loadingState)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
