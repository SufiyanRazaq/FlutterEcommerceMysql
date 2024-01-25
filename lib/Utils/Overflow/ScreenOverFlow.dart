import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double pageView(BuildContext context) => screenHeight(context) / 2.13;

  static double pageViewContainers(BuildContext context) =>
      screenHeight(context) / 3.10;

  static double pageViewTextController(BuildContext context) =>
      screenHeight(context) / 5.69;

  static double height5(BuildContext context) =>
      screenHeight(context) / 136.684;

  static double height10(BuildContext context) => screenHeight(context) / 70.34;

  static double height15(BuildContext context) => screenHeight(context) / 47.56;

  static double height20(BuildContext context) => screenHeight(context) / 36.17;

  static double height30(BuildContext context) => screenHeight(context) / 22.78;

  static double height45(BuildContext context) => screenHeight(context) / 15.83;

  static double width10(BuildContext context) => screenHeight(context) / 70.34;

  static double width15(BuildContext context) => screenHeight(context) / 47.56;

  static double width20(BuildContext context) => screenHeight(context) / 36.17;

  static double width30(BuildContext context) => screenHeight(context) / 22.78;

  static double width45(BuildContext context) => screenHeight(context) / 15.83;

  static double font16(BuildContext context) => screenHeight(context) / 42.71;

  static double font26(BuildContext context) => screenHeight(context) / 26.28;

  static double font20(BuildContext context) => screenHeight(context) / 36.17;

  static double radius15(BuildContext context) => screenHeight(context) / 47.56;

  static double radius20(BuildContext context) => screenHeight(context) / 36.17;

  static double radius30(BuildContext context) => screenHeight(context) / 22.78;

  static double iconSize24(BuildContext context) =>
      screenHeight(context) / 28.46;

  static double iconSize16(BuildContext context) =>
      screenHeight(context) / 42.71;

  static double ListViewImgSize(BuildContext context) =>
      screenWidth(context) / 3.67;

  static double ListViewTextContainerSize(BuildContext context) =>
      screenWidth(context) / 4.41;

  static double popularFoodImgSize(BuildContext context) =>
      screenHeight(context) / 1.95;

  static double bottomHeightBar(BuildContext context) =>
      screenHeight(context) / 5.69;

  static double splashImg(BuildContext context) => screenHeight(context) / 3.38;
}
