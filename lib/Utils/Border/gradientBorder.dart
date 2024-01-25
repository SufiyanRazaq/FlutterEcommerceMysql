import 'package:flutter/material.dart';

class GradientBorder extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final double width;

  GradientBorder({
    required this.child,
    required this.colors,
    this.width = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(width),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: child,
        ),
      ),
    );
  }
}
