import 'package:flutter/material.dart';

class ButtonViewModel {
  final VoidCallback? onTap; // Changed to VoidCallback for better readability
  final String buttonText;
  final double width; // Width of the button
  final double height; // Height of the button
  final Color colorAway;
  final Color colorPressed;
  final Color borderColorAway;
  final Color borderColorPressed;

  ButtonViewModel({
    required this.onTap,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.colorAway,
    required this.colorPressed,
    required this.borderColorAway,
    required this.borderColorPressed,
  });
}