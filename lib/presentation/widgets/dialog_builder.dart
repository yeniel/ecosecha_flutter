import 'package:ecosecha_flutter/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator({required String text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: LoadingIndicator(text: text),
        );
      },
    );
  }

  Future<void> showSimpleDialog({required String text, VoidCallback? onPressed}) async {
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
          onPressed: onPressed ?? () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    return showAlertDialog(alertDialog);
  }

  Future<void> showAnonymousLoginDialog({
    required VoidCallback onPressedSignIn,
    required VoidCallback onPressedSignUp,
  }) async {
    var S = AppLocalizations.of(context)!;

    var alertDialog = AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(S.anonymous_login_error),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.anonymous_login_sign_in),
          onPressed: onPressedSignIn,
        ),
        TextButton(
          child: Text(S.anonymous_login_sign_up),
          onPressed: onPressedSignUp,
        ),
      ],
    );

    return showAlertDialog(alertDialog);
  }

  Future<void> showAlertDialog(AlertDialog alertDialog) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => alertDialog);
  }

  Future<bool> hideOpenDialog() async {
    return Navigator.of(context).maybePop();
  }
}
