import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.submissionFailureInvalidCredentials) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(S.invalid_credentials_error)),
            );
        } else if (state.status == LoginStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(S.server_error)),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(S.loginHead, style: textTheme.headlineMedium, textAlign: TextAlign.center),
          Text(S.loginBody, style: textTheme.bodyLarge, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          _UsernameInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _LoginButton(),
          // TODO: Add a feature flag to show this button
          // _SignUpButton(),
          _SkipButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) => context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: S.user,
            errorText: state.username.invalid ? S.invalidUser : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: S.password,
            errorText: state.password.invalid ? S.invalidPassword : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (!state.isAnonymousLogin &&
            (state.status == LoginStatus.submissionInProgress || state.status == LoginStatus.submissionSuccess)) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ElevatedButton(
            key: const Key('LoginForm_loginButton'),
            child: Text(S.login),
            onPressed: state.status.isValidated && !state.isAnonymousLogin
                ? () {
                    context.read<LoginBloc>().add(const LoginSubmitted(isAnonymousLogin: false));
                  }
                : null,
          );
        }
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('LoginForm_signUpButton'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: Text(S.login_form_sign_up),
          onPressed: () {
            context.read<LoginBloc>().add(const LoginSignUp());
          },
        );
      },
    );
  }
}

class _SkipButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isAnonymousLogin &&
            (state.status == LoginStatus.submissionInProgress || state.status == LoginStatus.submissionSuccess)) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return OutlinedButton(
              key: const Key('LoginForm_skipButton'),
              child: Text(S.skipLogin),
              onPressed: () {
                context.read<LoginBloc>().add(const LoginSubmitted(isAnonymousLogin: true));
              });
        }
      },
    );
  }
}
