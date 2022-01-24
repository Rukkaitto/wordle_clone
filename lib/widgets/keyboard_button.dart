import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function() onTap;
  final double width;
  final double height;

  const KeyboardButton({
    required this.child,
    required this.onTap,
    this.color = Colors.grey,
    this.width = 35.0,
    this.height = 50.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
