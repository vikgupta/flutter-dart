import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future<void> _pickImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage),
          radius: 40,
        ),
        FlatButton.icon(
          onPressed: _pickImage, 
          icon: Icon(Icons.image), 
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}