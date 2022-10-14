import 'package:ecosecha_flutter/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator({required String text}) {
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

  Future<void> showSimpleDialog({required String text}) async {
    var alertDialog = AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(text),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return showAlertDialog(alertDialog);
  }

  Future<void> showAlertDialog(AlertDialog alertDialog) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => alertDialog
    );
  }

  Future<bool> hideOpenDialog() async {
    return Navigator.of(context).maybePop();
  }
}