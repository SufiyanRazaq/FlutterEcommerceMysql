import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  final String imagePath;

  const ProfilePicture({super.key, required this.imagePath});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage:
          widget.imagePath.isNotEmpty ? NetworkImage(widget.imagePath) : null,
    );
  }
}
