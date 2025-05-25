import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87,
      height: 87,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFEEDBED),
          width: 3,
        ),
      ),
      child: ClipOval(
        child: Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}