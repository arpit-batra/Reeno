import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

enum ImageType {
  camera,
  gallery,
}

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  Future<void> _pickImage(imageType) async {
    final _imagePicker = ImagePicker();
    var _pickedImageXFile;
    if (imageType == ImageType.camera) {
      _pickedImageXFile = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 90, maxWidth: 200);
    } else {
      _pickedImageXFile = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 90, maxWidth: 200);
    }
    setState(() {
      _pickedImageFile = File(_pickedImageXFile!.path);
    });
    widget.imagePickFn(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: _pickedImageFile != null
              ? FileImage(_pickedImageFile!)
              : Image.asset('./assets/default_prof_pic.jpeg').image,
          backgroundColor: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: (() {
                _pickImage(ImageType.camera);
              }),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Profile Pic'),
            ),
            TextButton.icon(
              onPressed: (() {
                _pickImage(ImageType.gallery);
              }),
              icon: const Icon(Icons.image),
              label: const Text('Pick from Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}
