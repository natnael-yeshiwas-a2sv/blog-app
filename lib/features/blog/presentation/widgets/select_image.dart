import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class SelectImage extends StatefulWidget {
   Null Function(File? file) onSelected;
  SelectImage({super.key,  required  this.onSelected});
  

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  File? _image;
  var imagePicker;
   @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        XFile image = await imagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                  widget.onSelected(File(image.path));
                });
                
      },
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.red[200]),
        child: _image != null
            ? Image.file(
                  _image!,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.fitHeight,
                )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.red[200]),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
      ),
    );
  }
}
