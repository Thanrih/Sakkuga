import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap;
  final String buttonText;
  final double width; // Largura do botão
  final double height; // Altura do botão
  final Color colorAway;
  final Color colorPressed;
  final Color borderColorAway;
  final Color borderColorPressed;


  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.width,
    required this.height,
    required this.colorAway,
    required this.colorPressed,
    required this.borderColorAway,
    required this.borderColorPressed,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  Color _getBackgroundColor() {
    return _isPressed ? widget.colorPressed : widget.colorAway;
  }

  Color _getTextColor() {
    return _isPressed ? widget.colorAway : widget.colorPressed;
  }

  Color _getBorderColor() {
    return _isPressed ? widget.colorAway : widget.colorPressed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: widget.width, // Definindo a largura do botão
        height: widget.height, // Definindo a altura do botão
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _getBorderColor()),
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: _getTextColor(),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
