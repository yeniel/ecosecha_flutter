import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(),
          _getText(displayedText: displayedText, context: context),
        ],
      ),
    );
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(child: const CircularProgressIndicator(strokeWidth: 3), width: 32, height: 32),
        padding: const EdgeInsets.only(bottom: 16));
  }

  Text _getText({required String displayedText, required BuildContext context}) {
    var textTheme = Theme.of(context).textTheme;

    return Text(
      displayedText,
      style: textTheme.bodyText1,
      textAlign: TextAlign.center,
    );
  }
}
