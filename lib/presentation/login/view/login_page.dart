import 'package:ecosecha_flutter/data/repositories/auth/auth_service.dart';
import 'package:ecosecha_flutter/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ecosecha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authService:
                  RepositoryProvider.of<AuthService>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
