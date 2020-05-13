import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function setPickedImage;

  ImageInput(this.setPickedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takeImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera, 
      maxWidth: 600
    );

    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.setPickedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 125,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )
          ),
          alignment: Alignment.center,
          child: _storedImage != null ?
            Image.file(
              _storedImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ):
            Text(
              'No image taken yet',
              textAlign: TextAlign.center,
            ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takeImage,
          ),
        ),
      ],
    );
  }
}