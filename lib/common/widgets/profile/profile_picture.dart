import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              _imageFile != null
                  ? FileImage(_imageFile!)
                  : AssetImage('assets/Profile Photo-1.png') as ImageProvider,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey,
            child: Icon(Icons.edit, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}
