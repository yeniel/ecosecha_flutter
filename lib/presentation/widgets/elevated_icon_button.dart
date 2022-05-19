import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({Key? key, required this.onPressed, required this.icon}) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(icon),
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }
}
