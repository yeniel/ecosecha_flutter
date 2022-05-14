import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/authentication/bloc/authentication_bloc.dart';
import 'presentation/home/home.dart';
import 'presentation/login/login.dart';
import 'presentation/splash/splash.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.authService, required this.repository}) : super(key: key);

  final AuthService authService;
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authService,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authService: authService, repository: repository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
