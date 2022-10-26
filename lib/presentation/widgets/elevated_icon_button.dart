import 'package:flutter/material.dart';

class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({Key? key, required this.onPressed, required this.icon, this.outlined = false}) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(icon, color: Colors.brown),
      style: ElevatedButton.styleFrom(
        shadowColor: outlined ? Colors.transparent : Colors.orange,
        surfaceTintColor: outlined ? Colors.transparent : Colors.orange,
        backgroundColor: outlined ? Colors.transparent : Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }
}
