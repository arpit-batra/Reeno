import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:reeno/pickers/user_image_picker.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/ui/circular_border.dart';

class ProfilePicWidget extends StatefulWidget {
  final String imageUrl;
  const ProfilePicWidget(this.imageUrl, {Key? key}) : super(key: key);

  @override
  _ProfilePicWidgetState createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  bool _loadingState = false;

  Future<void> _pickAndUpload(imageType, imageUrl, context) async {
    final _imagePicker = ImagePicker();
    var _pickedImageXFile;
    if (imageType == ImageType.camera) {
      _pickedImageXFile = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 90, maxWidth: 200);
    } else {
      _pickedImageXFile = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 90, maxWidth: 200);
    }
    var url = imageUrl;
    final currUserUid = FirebaseAuth.instance.currentUser!.uid;
    print(url);
    if (_pickedImageXFile != null) {
      print("got image");
      final _pickedImageFile = File(_pickedImageXFile!.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('$currUserUid.jpg');

      print("uploading");
      await ref.putFile(_pickedImageFile);
      print("uploaded");
      url = await ref.getDownloadURL();
      print("got url, uploading in user");
      await Provider.of<UserProvider>(context, listen: false)
          .updateImageUrl(imageUrl);
      print("uploaded");
    }
  }

  Widget _imageSelectorButton(imageType, imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularBorder(
              borderWidth: 1,
              borderColor: Colors.grey,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _loadingState = true;
                    });
                    _pickAndUpload(imageType, imageUrl, context);

                    setState(() {
                      _loadingState = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  icon: imageType == ImageType.camera
                      ? Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(Icons.image,
                          color: Theme.of(context).primaryColor)),
            ),
          ),
          if (imageType == ImageType.camera) const Text("Camera"),
          if (imageType == ImageType.gallery) const Text("Gallery"),
        ],
      ),
    );
  }

  Widget _bottomSheetBuilder(BuildContext context, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Profile Picture",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            _imageSelectorButton(ImageType.camera, imageUrl),
            _imageSelectorButton(ImageType.gallery, imageUrl),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding imageUrl -> ${widget.imageUrl}");
    return Container(
      width: double.infinity,
      height: 100,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
            ),
          ),
          Center(child: CircularProgressIndicator()),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 100,
                height: 100,
                // decoration: BoxDecoration(image: ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              left: (AppDrawer.appDrawerWidth / 2) + 10,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                      onPressed: (() {
                        print("Tap on prof pic");
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return _bottomSheetBuilder(
                                context, widget.imageUrl);
                          },
                        );
                      }),
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[700],
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
