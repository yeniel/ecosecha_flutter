import 'package:ecosecha_flutter/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/app_icon.png'),
            LoadingIndicator(text: S.splash_page_message),
          ],
        ),
      ),
    );
  }
}
