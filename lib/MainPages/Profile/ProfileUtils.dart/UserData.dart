// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:MysqlApp/Auth/Functions.dart';
import 'package:MysqlApp/Auth/Login/login.dart';
import 'package:MysqlApp/MainPages/Profile/ProfileUtils.dart/profilePicture.dart';
import 'package:MysqlApp/Utils/Overflow/ScreenOverFlow.dart';
import 'package:MysqlApp/Utils/TextStyles/BigText.dart';
import 'package:mysql1/mysql1.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final UserController userController = Get.find<UserController>();
  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();
    _loadSelectedImagePath();
  }

  void _loadSelectedImagePath() async {
    if (userController.user.value?.id != null) {
      String? imagePath =
          await getImagePathFromDatabase(userController.user.value!.id!);
      setState(() {
        selectedImagePath = imagePath ?? '';
      });
    }
  }

  Future<void> saveImagePathInDatabase(int userId, String imagePath) async {
    MySqlConnection? conn;
    try {
      conn = await userController.connectToDatabase();

      var result = await conn.query(
        'SELECT * FROM images WHERE userid = ?',
        [userId],
      );

      if (result.isNotEmpty) {
        await conn.query(
          'UPDATE images SET ImagePath = ? WHERE userid = ?',
          [imagePath, userId],
        );
      } else {
        await conn.query(
          'INSERT INTO images (userid, ImagePath) VALUES (?, ?)',
          [userId, imagePath],
        );
      }
    } finally {
      await conn?.close();
    }
  }

  Future<String?> getImagePathFromDatabase(int userId) async {
    MySqlConnection? conn;
    try {
      conn = await userController.connectToDatabase();

      var result = await conn.query(
        'SELECT ImagePath FROM images WHERE userid = ?',
        [userId],
      );

      if (result.isNotEmpty) {
        dynamic imagePathData = result.first['ImagePath'];
        print('Image Path from Database: $imagePathData');

        if (imagePathData is String) {
          return imagePathData;
        } else if (imagePathData is Uint8List) {
          return String.fromCharCodes(imagePathData);
        }
      }

      return null;
    } finally {
      await conn?.close();
    }
  }

  void _showImageSelectionDialog(int userId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Profile Picture'),
          content: Column(
            children: [
              InkWell(
                onTap: () async {
                  String imagePath =
                      'https://raw.githubusercontent.com/SufiyanRazaq/image/main/men.png';
                  await saveImagePathInDatabase(userId, imagePath);
                  setState(() {
                    selectedImagePath = imagePath;
                  });
                  Navigator.pop(context);
                },
                child: Image.network(
                  'https://raw.githubusercontent.com/SufiyanRazaq/image/main/men.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  String imagePath =
                      'https://raw.githubusercontent.com/SufiyanRazaq/image/main/women.png';
                  await saveImagePathInDatabase(userId, imagePath);
                  setState(() {
                    selectedImagePath = imagePath;
                  });
                  Navigator.pop(context);
                },
                child: Image.network(
                  'https://raw.githubusercontent.com/SufiyanRazaq/image/main/women.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<UserController>(
        init: userController,
        builder: (userController) {
          final User? user = userController.user.value;
          if (user == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Profile',
                  style: GoogleFonts.aBeeZee(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(const SignIn());
                      },
                      child: Container(
                        width: 200,
                        height: Dimensions.height20(context) * 3,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20(context),
                            right: Dimensions.width20(context)),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20(context))),
                        child: Center(
                          child: BigText(
                            text: "Sign In",
                            color: Colors.white,
                            size: Dimensions.font20(context),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please log in to view your profile',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: GetBuilder<UserController>(
                  init: userController,
                  builder: (userController) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showImageSelectionDialog(
                                        userController.user.value!.id ?? 0);
                                  },
                                  child: ProfilePicture(
                                      imagePath: selectedImagePath),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        user.sinceMember != null
                                            ? DateFormat('dd / MM / yyyy')
                                                .format(DateTime.parse(
                                                    user.sinceMember!))
                                            : '',
                                        style:
                                            GoogleFonts.aBeeZee(fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        user.email,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    user.name,
                                    style: GoogleFonts.aBeeZee(fontSize: 16.0),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    userController.logOut();
                                    Get.to(
                                      const SignIn(),
                                    );
                                  },
                                  child: Text(
                                    'Logout',
                                    style: GoogleFonts.aBeeZee(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
