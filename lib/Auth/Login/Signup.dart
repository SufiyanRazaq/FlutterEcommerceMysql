// ignore_for_file: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:MysqlApp/Auth/Functions.dart';
import 'package:MysqlApp/Auth/AuthUtils/snackBar/snackbar.dart';
import 'package:MysqlApp/Utils/NavBar/BottomNavBar.dart';
import 'package:MysqlApp/Utils/Overflow/ScreenOverFlow.dart';
import 'package:MysqlApp/Utils/TextFields/LoginTextFields.dart';
import 'package:MysqlApp/Utils/TextStyles/BigText.dart';

class SignUp extends StatefulWidget {
  final Function(PhoneNumber)? onPhoneNumberChanged;
  const SignUp({Key? key, this.onPhoneNumberChanged}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
//  final phoneController = TextEditingController();
  UserController userController = Get.put(UserController());
  bool isLoading = false;
  bool isPasswordVisible = false;
  String countryCode = '';

  void registration(UserController userController) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    //  String phone = phoneController.text.trim();
    if (name.isEmpty) {
      showCustomSnackBar(
        "Type in your name",
        title: "Name",
      );
    } else if (email.isEmpty) {
      showCustomSnackBar(
        "Type in your email address",
        title: "Email address",
      );
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar(
        "Type in your valid email address",
        title: "Valid Email address",
      );
    } else if (password.isEmpty) {
      showCustomSnackBar(
        "Type in your password",
        title: "Password",
      );
    } else if (password.length < 6) {
      showCustomSnackBar(
        "Password cannot be less than six characters",
        title: "Password",
      );
    } else {
      setState(() {
        isLoading = true;
      });

      try {
        bool success = await userController.registerUser(
            name,
            email,
            // phone,
            password);
        if (success) {
          // Navigate to the verification page with the registered email
          Get.to(NavBar());
        } else {
          showCustomSnackBar(
            "Registration failed. Please try again later.",
            title: "Registration",
          );
        }
      } catch (e) {
        print('Error during registration: $e');
        showCustomSnackBar(
          "An error occurred during registration.",
          title: "Error",
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

/*
  bool isDialCodeSet = false;
  String _selectedPhoneNumber = '';
  String getPhoneNumber() {
    return _selectedPhoneNumber;
  }

  void handlePhoneNumberChanged(PhoneNumber number) {
    String newPhoneNumber = number.phoneNumber ?? '';
    if (!isDialCodeSet || countryCode != number.isoCode) {
      countryCode = number.isoCode ?? '';
      _selectedPhoneNumber = newPhoneNumber;
      phoneController.text = '+${number.dialCode} $_selectedPhoneNumber';
      isDialCodeSet = true;
    } else if (!phoneController.text.startsWith('+${number.dialCode}')) {
      _selectedPhoneNumber = newPhoneNumber;
      phoneController.text = '+${number.dialCode} $_selectedPhoneNumber'
          .replaceAll('+${number.dialCode}', '');
    }

    if (widget.onPhoneNumberChanged != null) {
      widget.onPhoneNumberChanged!(number);
    }
  }

  bool phoneNumberSet = false;*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight(context) * 0.050,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 200, left: 20),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.aboreto(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font20(context) +
                              Dimensions.font20(context) / 3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight(context) * 0.032,
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

                    /*    InternationalPhoneNumberInput(
                      textFieldController: phoneController,
                      hintText: 'Phone',
                      onInputChanged: handlePhoneNumberChanged,
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      textStyle: const TextStyle(color: Colors.black),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),*/
                    SizedBox(
                      height: Dimensions.height10(context),
                    ),
                    AppTextField(
                      textController: nameController,
                      hintText: "Name",
                      leftIcon: Icons.person,
                    ),
                    SizedBox(
                      height: Dimensions.height10(context),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          registration(userController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth(context) / 2,
                          height: Dimensions.screenHeight(context) / 13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius30(context)),
                            color: const Color.fromARGB(255, 102, 104, 209),
                          ),
                          child: Center(
                            child: BigText(
                              text: "Sign Up",
                              color: Colors.white,
                              size: Dimensions.font20(context) +
                                  Dimensions.font20(context) / 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height15(context),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black,
                              fontSize: Dimensions.font20(context)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight(context) * 0.015,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Sign up using one of the following methods",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.grey[800],
                              fontSize: Dimensions.font16(context)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 /* Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.only(
                          right: Dimensions.height20(context),
                          left: Dimensions.height20(context),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius15(context)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: const Offset(2, 1),
                              color: Colors.grey.withOpacity(0.3),
                            )
                          ],
                        ),
                        child: InternationalPhoneNumberInput(
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: phoneController,
                          formatInput: true,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          onInputChanged: (PhoneNumber value) {
                            if (!phoneNumberSet) {
                              phoneController.text = value.phoneNumber ?? '';
                            }
                          },
                          onInputValidated: (bool isValid) {
                            // Disable editing when phoneNumber is set
                            if (phoneNumberSet) {
                              phoneController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: phoneController.text.length),
                              );
                            }
                          },
                          onSaved: (PhoneNumber? phoneNumber) {
                            // Update the flag to make the field non-editable
                            phoneNumberSet = true;
                          },
                        ),
                      ),*/