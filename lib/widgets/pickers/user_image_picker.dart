import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _userImageFile;
  void _pickUserImage() async {
    final _picker = ImagePicker();
    final _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedImage != null) {
      //return Navigator.of(context).pop();
      //}
      final pickedImageFile = File(_pickedImage.path);

      setState(() {
        _userImageFile = pickedImageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _userImageFile != null ? FileImage(_userImageFile) : null,
          //TODO: creat4e a default image
        ),
        TextButton.icon(
          onPressed: _pickUserImage,
          icon: Icon(Icons.camera_alt),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
