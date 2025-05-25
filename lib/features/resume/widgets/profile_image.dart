import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;

  const ProfileImage({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: imageFile == null
          ? Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey,
              ),
            )
          : Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.file(
                  imageFile!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
