import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onpressed;

  const CustomizedButton({
    super.key,
    required this.onpressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onpressed,
      backgroundColor: const Color(0xFF659AFF),
      child: Icon(
        icon.icon,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
