import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reeno/pickers/user_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/phone_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart' as CustomUser;

class GetUserInfoScreen extends StatefulWidget {
  const GetUserInfoScreen({Key? key}) : super(key: key);

  static const routeName = '/get-user-info';

  @override
  _GetUserInfoScreenState createState() => _GetUserInfoScreenState();
}

class _GetUserInfoScreenState extends State<GetUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;
  bool _loadingState = false;
  String? _userFullName;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  Future<void> _submitInfo(BuildContext context, VoidCallback onSuccess) async {
    final isValid = _formKey.currentState!.validate();
    //TODO Upload image
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _loadingState = true;
      });
      _formKey.currentState!.save();
      final currentUser = CustomUser.User(
        phone: Provider.of<PhoneProvider>(context, listen: false).phoneNumber,
        name: _userFullName,
        imageUrl: "Sample for now",
      );
      print(currentUser.phone);
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .withConverter(
              fromFirestore: CustomUser.User.fromFirestore,
              toFirestore: (CustomUser.User user, options) =>
                  user.toFirestore());
      //TODO add try catch
      await docRef.add(currentUser);
      setState(() {
        _loadingState = false;
      });
      print("Reached Here");
      onSuccess.call();
      // if (mounted)
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserImagePicker(_pickedImage),
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userFullName = value;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _loadingState
                            ? null
                            : () {
                                _submitInfo(context, () {
                                  print("onSuccess call initiated");
                                  if (!mounted) {
                                    return;
                                  }

                                  print("Mounted, this should not run");
                                  Navigator.of(context).pop();
                                  print(Navigator.of(context).toString());
                                });
                              },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
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
