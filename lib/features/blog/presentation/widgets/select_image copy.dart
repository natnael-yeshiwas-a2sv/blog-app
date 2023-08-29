import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageSelect extends StatefulWidget {
  Null Function(File? file) onSelected;
  ProfileImageSelect({super.key, required this.onSelected});

  @override
  State<ProfileImageSelect> createState() => _ProfileImageSelectState();
}

class _ProfileImageSelectState extends State<ProfileImageSelect> {
  File? _image;
  var imagePicker;
  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        XFile image = await imagePicker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 50,
            preferredCameraDevice: CameraDevice.front);
        setState(() {
          _image = File(image.path);
          widget.onSelected(File(image.path));
        });
      },
      child: Container(
        width: 30,
        height: 20,
        child: 
            IconButton(
                icon: Icon(Icons.camera_alt, size: 20),
                onPressed: () async {
                  XFile image = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      preferredCameraDevice: CameraDevice.front);
                  setState(() {
                    _image = File(image.path);
                    widget.onSelected(File(image.path));
                  });
                },
              ),
      ),
    );
  }
}
