import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  Future<void> _pickImage() async {
    final _imagePicker = ImagePicker();
    final _pickedImageXFile = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 90, maxWidth: 150);
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
          radius: 40,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text('Add profile pic')),
      ],
    );
  }
}
