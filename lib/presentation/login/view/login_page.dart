import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(S.appName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              analyticsManager: context.read<AnalyticsManager>(),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
