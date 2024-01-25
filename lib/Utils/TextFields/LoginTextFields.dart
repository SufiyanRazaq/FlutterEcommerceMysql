// app_textfield.dart
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:MysqlApp/Utils/Overflow/ScreenOverFlow.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final bool isObsecure;
  final VoidCallback? onLeftIconPressed;
  final VoidCallback? onRightIconPressed;
  final Function(PhoneNumber)? onPhoneNumberChanged;

  AppTextField({
    Key? key,
    required this.hintText,
    this.isObsecure = false,
    this.leftIcon,
    this.rightIcon,
    required this.textController,
    this.onLeftIconPressed,
    this.onRightIconPressed,
    this.onPhoneNumberChanged,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: Dimensions.height20(context),
        left: Dimensions.height20(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15(context)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(2, 1),
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: TextField(
        obscureText: widget.isObsecure,
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: InkWell(
            onTap: () {
              if (widget.onLeftIconPressed != null) {
                widget.onLeftIconPressed!();
              }
            },
            child: Icon(
              widget.leftIcon,
              color: const Color.fromARGB(255, 102, 104, 209),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (widget.onRightIconPressed != null) {
                widget.onRightIconPressed!();
              }
            },
            child: Icon(
              widget.rightIcon,
              color: const Color.fromARGB(255, 102, 104, 209),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radius20(context),
            ),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radius15(context),
            ),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
