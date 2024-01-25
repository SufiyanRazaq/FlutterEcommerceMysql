// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:MysqlApp/Utils/Overflow/ScreenOverFlow.dart';

class BigText extends StatelessWidget {
  BigText({
    super.key,
    this.color = const Color.fromARGB(255, 43, 170, 88),
    required this.text,
    this.overFlow = TextOverflow.ellipsis,
    this.size = 20,
  });
  final Color color;
  final String text;
  double size;
  TextOverflow overFlow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20(context) : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
