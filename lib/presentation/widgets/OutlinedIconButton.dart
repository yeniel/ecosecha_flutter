import 'package:flutter/material.dart';

class OutlinedIconButton extends StatelessWidget {
  const OutlinedIconButton({Key? key, required this.onPressed, required this.icon}) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Icon(icon),
      style: OutlinedButton.styleFrom(
        primary: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
