import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reeno/app_config.dart';
import 'package:reeno/pickers/user_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/phone_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reeno/providers/user_provider.dart';

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
  final currUserUid = FirebaseAuth.instance.currentUser!.uid;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  Future<String> _uploadProfImage() async {
    //Link of default image
    final appConfig = AppConfig.of(context)!;
    var url = await FirebaseStorage.instance
        .refFromURL(appConfig.defaultImageLink)
        .getDownloadURL();
    print(url);
    if (_userImageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('$currUserUid.jpg');

      await ref.putFile(_userImageFile!);

      url = await ref.getDownloadURL();
    }
    return url;
  }

  Future<void> _submitInfo(BuildContext context, VoidCallback onSuccess) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      setState(() {
        _loadingState = true;
      });
      _formKey.currentState!.save();

      final imageUrl = await _uploadProfImage();
      final phone =
          Provider.of<PhoneProvider>(context, listen: false).phoneNumber;
      // final currentUser = CustomUser.User(
      //   phone: Provider.of<PhoneProvider>(context, listen: false).phoneNumber,
      //   name: _userFullName,
      //   imageUrl: imageUrl,
      // );
      // final docRef = FirebaseFirestore.instance
      //     .collection('users')
      //     .withConverter(
      //         fromFirestore: CustomUser.User.fromFirestore,
      //         toFirestore: (CustomUser.User user, options) =>
      //             user.toFirestore());
      // //TODO add try catch
      // await docRef.doc(currUserUid).set(currentUser);
      await Provider.of<UserProvider>(context, listen: false)
          .addUser(currUserUid, null, phone, imageUrl, _userFullName);
      setState(() {
        _loadingState = false;
      });
      print("Reached Here");
      onSuccess.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
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
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.words,
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
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
      ),
    );
  }
}
