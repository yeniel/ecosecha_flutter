import 'package:ecosecha_flutter/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator({required BuildContext context, required String text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LoadingIndicator(
              text: text
          ),
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).maybePop();
  }
}