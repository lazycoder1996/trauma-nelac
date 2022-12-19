import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? fgColor;
  const CustomButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.bgColor,
    this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}
