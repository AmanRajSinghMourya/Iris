import 'package:flutter/material.dart';
import 'package:iris/utilities/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(cardBackgroundColor),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
