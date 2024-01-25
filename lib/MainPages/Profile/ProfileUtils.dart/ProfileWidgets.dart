import 'package:flutter/material.dart';
import 'package:MysqlApp/Utils/Border/gradientBorder.dart';

class ProfileWidgets extends StatefulWidget {
  const ProfileWidgets({super.key});

  @override
  State<ProfileWidgets> createState() => _ProfileWidgetsState();
}

class _ProfileWidgetsState extends State<ProfileWidgets> {
  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      colors: const [
        Color.fromARGB(255, 99, 97, 219),
        Color.fromARGB(255, 59, 226, 255),
        Colors.blue
      ],
      width: 4.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Center(
          child: Text(
            'Your Content',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
