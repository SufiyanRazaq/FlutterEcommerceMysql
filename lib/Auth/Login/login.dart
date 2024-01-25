// ignore_for_file: file_names

import 'package:flutter/foundation.dart' show Key, kDebugMode;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';
import 'package:MysqlApp/Auth/AuthUtils/snackBar/snackbar.dart';
import 'package:MysqlApp/Auth/Functions.dart';
import 'package:MysqlApp/Auth/Login/Signup.dart';
import 'package:MysqlApp/MainPages/HomePage/homepage.dart';
import 'package:MysqlApp/Utils/NavBar/BottomNavBar.dart';
import 'package:MysqlApp/Utils/Overflow/ScreenOverFlow.dart';
import 'package:MysqlApp/Utils/TextFields/LoginTextFields.dart';
import 'package:MysqlApp/Utils/TextStyles/BigText.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Get.put(UserController());
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar(
        "Type in your email address",
        title: "Email address",
      );
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar(
        "Type in your Valid email address",
        title: "Valid Email address",
      );
    } else if (password.isEmpty) {
      showCustomSnackBar(
        "Type in your password",
        title: "Password",
      );
    } else {
      UserController userController = UserController();
      MySqlConnection? conn;
      try {
        conn = await userController.connectToDatabase();
        if (kDebugMode) {
          print("Success");
        }
        final results = await conn.query(
          'SELECT name, email, username FROM users WHERE email = ? AND password = ? LIMIT 1',
          [email, password],
        );
        if (results.isNotEmpty) {
          String email = results.first[1] as String? ?? '';
          await conn.close();
          Get.to(const HomePage());
          if (kDebugMode) {
            print('Login successful');
          }
        } else {
          // Login failed
          showCustomSnackBar(
            "Invalid email or password",
            title: "Login failed",
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error connecting to database: $e');
        }
      } finally {
        await conn?.close();
      }
    }
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight(context) * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20(context)),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: Dimensions.font20(context) * 3 +
                                      Dimensions.font20(context) / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Sign into your account",
                                style: GoogleFonts.aBeeZee(
                                  fontSize: Dimensions.font20(context),
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20(context),
                        ),
                        AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          leftIcon: Icons.email,
                        ),
                        SizedBox(
                          height: Dimensions.height10(context),
                        ),
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          isObsecure: !isPasswordVisible,
                          rightIcon: isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          leftIcon: Icons.password,
                          onRightIconPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        SizedBox(
                          height: Dimensions.height20(context),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Sign into your account",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width20(context),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight(context) * 0.03,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {});
                              bool success = await _userController.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              if (success) {
                                Get.to(NavBar());
                                if (kDebugMode) {
                                  print('Login successful');
                                }
                              } else {
                                showCustomSnackBar(
                                  "Invalid email or password",
                                  title: "Login failed",
                                );
                              }
                            }
                          },
                          child: Container(
                            width: Dimensions.screenWidth(context) / 2,
                            height: Dimensions.screenHeight(context) / 13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radius30(context)),
                                color:
                                    const Color.fromARGB(255, 102, 104, 209)),
                            child: Center(
                              child: BigText(
                                text: "Sign In",
                                color: Colors.white,
                                size: Dimensions.font20(context) +
                                    Dimensions.font20(context) / 3,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight(context) * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Don't an account?",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20(context)),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => const SignUp(),
                                        transition: Transition.fade),
                                  text: " Create",
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.black,
                                      fontSize: Dimensions.font20(context),
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
