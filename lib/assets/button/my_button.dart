import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/button/button_viewmodel.dart';

class MyButton extends StatefulWidget {
  final ButtonViewModel viewModel;

  const MyButton({
    super.key,
    required this.viewModel,
  });

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  Color _getBackgroundColor() {
    return _isPressed ? widget.viewModel.colorPressed : widget.viewModel.colorAway;
  }

  Color _getTextColor() {
    return _isPressed ? widget.viewModel.colorAway : widget.viewModel.colorPressed;
  }

  Color _getBorderColor() {
    return _isPressed ? widget.viewModel.colorAway : widget.viewModel.colorPressed;
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
        if (widget.viewModel.onTap != null) {
          widget.viewModel.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        width: widget.viewModel.width, // Setting the button width
        height: widget.viewModel.height, // Setting the button height
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _getBorderColor()),
        ),
        child: Center(
          child: Text(
            widget.viewModel.buttonText,
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