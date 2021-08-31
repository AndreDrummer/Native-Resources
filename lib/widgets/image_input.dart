import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  final Function onSelectImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    PickedFile? imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage?.existsSync() ?? false
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('Nnehuma imagem!'),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text('Tirar foto'),
          ),
        ),
      ],
    );
  }
}
