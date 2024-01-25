import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MysqlApp/Auth/Functions.dart';
import 'package:MysqlApp/MainPages/Profile/ProfileUtils.dart/ProfileWidgets.dart';
import 'package:MysqlApp/MainPages/Profile/ProfileUtils.dart/UserData.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: UserData(),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: ProfileWidgets(),
            ),
          ],
        ),
      ),
    );
  }
}
