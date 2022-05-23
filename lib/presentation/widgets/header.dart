import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.title, this.showBack = false, required this.onBack}) : super(key: key);

  final String title;
  final bool showBack;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (showBack)
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios, size: 32),
          ),
        Text(title.capitalizeFirstOfEach, style: textTheme.headline4),
      ],
    );
  }
}
